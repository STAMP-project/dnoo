#!/bin/sh
################################################################################
currentD=`pwd`

pomFile="pom.xml"
fileExtension="pitest_descartes"
sourcePomFile="pom.xml.$fileExtension"
dirList=". dnooLogs dnooStorage dnooHello dnooMain dnooIntegration"

mvn clean 2>&1 >/dev/null

for theDir in $dirList
do
   if test -f "$theDir/$sourcePomFile"
   then
      cp $theDir/$sourcePomFile $theDir/$pomFile
   fi
done
mvn install 2>&1 >/dev/null

echo "######## `date +%T`" 2>&1 | tee $fileExtension.traces

echo mvn org.pitest:pitest-maven:mutationCoverage 2>&1 | tee -a $fileExtension.traces
mvn org.pitest:pitest-maven:mutationCoverage 2>&1 | tee -a $fileExtension.traces

echo "######## `date +%T`" 2>&1 | tee -a $fileExtension.traces
