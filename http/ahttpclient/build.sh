#! /bin/bash

VESRION=1.0.0
SOURCE=./plugin/ahttpclient.go
BINARY=./plugin/ahttpclient.so

BuildTime=`date`
BuildGoVersion=`go version`


# Setup the -ldflags option for build 

LDFLAGS=" -s -w -X 'ahttp.client/src/build.Version=${VESRION}' \
-X 'ahttp.client/src/build.User=$(id -u -n)' \
-X 'ahttp.client/src/build.Time=${BuildTime}' \
-X 'ahttp.client/src/build.BuildGoVersion=${BuildGoVersion}' "


cd ./src
echo "clean old binaries....."
rm ${BINARY}
echo "clean old binaries ......... DONE"

echo "building plug-in....."

GO111MODULE=on go build -v -buildmode=plugin -ldflags="${LDFLAGS}" -o  ${BINARY} ${SOURCE}
echo "building plug-in ......... DONE"


mkdir -p $1/plugins/http
cp ${BINARY} $1/plugins/http/

echo "plugin ${BINARY} copied to $1/plugins/http "

