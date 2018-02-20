#!/bin/sh
# running tests
# default
# find all classes in target/test-classes and run each of them with jUnit
# if a dir name is specified, run tests of this directory only
################################################################################

CurrentDir=`pwd`

TargetTestDir="$1"

BuildDirList="`ls -d */target`"

JunitPath="/usr/share/java/junit4.jar"
TestRunFlags=

# silent build
BuildTraces="/tmp/run_hello_app_tests_`date +%Y%m%d_%Hh%M`.traces"
mvn clean package >$BuildTraces 2>&1
   
for BuildDir in $BuildDirList
do
   ObjDir="$BuildDir/classes"
   
   JarFile=`find $BuildDir -name "*.jar"`
   TestObjDir="$BuildDir/test-classes"
   if test "X$TestRunFlags" = "X"
   then
      TestRunFlags="-classpath $TestObjDir:$JarFile:"
   else
      TestRunFlags="$TestRunFlags:$TestObjDir:$JarFile"
   fi
done

TestRunFlags="$TestRunFlags:$JunitPath"

for BuildDir in $BuildDirList
do
   ObjDir="$BuildDir/classes"
   
   TestObjDir="$BuildDir/test-classes"
   TestMainPath="org.junit.runner.JUnitCore"
   
   cd $TestObjDir
   TestClassList=`find . -name "*.class" | sed -e "s/\.\///" -e "s/\.class//" -e "s/\//\./g"`
   cd $CurrentDir
   
   for testPath in $TestClassList
   do
      echo "------------------------------------------------------------"
      echo "---- $testPath"
      echo "---- java $TestRunFlags $TestMainPath $testPath"
      echo "------------------------------------------------------------"
      java $TestRunFlags $TestMainPath $testPath
   done
done
