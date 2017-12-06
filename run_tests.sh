#!/bin/sh
# running tests
# default
# find all classes in target/test-classes and run each of them with jUnit
# if a dir name is specified, run tests of this directory only
################################################################################

CurrentDir=`pwd`

TargetTestDir="$1"

BuildDir="target"
ObjDir="$BuildDir/classes"
RunFlags="-classpath $ObjDir"

# silent build
BuildTraces="/tmp/run_hello_app_tests_`date +%Y%m%d_%Hh%M`.traces"
mvn clean package >$BuildTraces 2>&1

JarFile=`find $BuildDir -name "*.jar"`
TestObjDir="$BuildDir/test-classes"
JunitPath="/usr/share/java/junit4.jar"
TestRunFlags="-classpath $TestObjDir:$JarFile:$JunitPath"
TestMainPath="org.junit.runner.JUnitCore"

cd $TestObjDir
TestClassList=`find . -name "*.class" | sed -e "s/\.\///" -e "s/\.class//" -e "s/\//\./g"`
cd $CurrentDir

for testPath in $TestClassList
do
   echo "------------------------------------------------------------"
   echo "---- $testPath"
   echo "------------------------------------------------------------"
   java $TestRunFlags $TestMainPath $testPath
done
