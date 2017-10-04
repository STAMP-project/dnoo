#!/bin/sh
# running HelloApp with arguments
################################################################################

args="$*"

CurrentDir=`pwd`

# silent build
BuildTraces="/tmp/run_hello_app_test_`date +%Y%m%d_%Hh%M`.traces"
mvn clean package >$BuildTraces 2>&1

BuildDirs="`ls -d */target`"
ClassPath=
for theDir in $BuildDirs
do
   ClassPath="$theDir/classes:$ClassPath"
done
RunFlags="-classpath $ClassPath"

SrcDir="*/src"
FileList=`find $SrcDir -name "*.java"`
MainName=`grep -w -l "main" $FileList | sed -e "s/.*\/java\///" -e "s/\.java//"`
MainClassFile=`grep -w -l "main" $FileList`

MainDir=`dirname $MainClassFile | sed -e "s/\/src.*$//"`
MainPackage=`dirname $MainName | sed -e "s/\//\./g"`
MainClass=`basename $MainName`
MainJavaPath="$MainPackage.$MainClass"

java $RunFlags $MainJavaPath $args
