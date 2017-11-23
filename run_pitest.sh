#!/bin/sh
################################################################################
currentD=`pwd`

pomFile="pom.xml"
sourcePomFile="pom.xml.pitest"
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

mvn org.pitest:pitest-maven:mutationCoverage 2>&1 | tee pitest.traces
