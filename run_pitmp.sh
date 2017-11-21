#!/bin/sh
################################################################################
currentD=`pwd`

pomFile="pom.xml"
sourcePomFile="pom.xml.pitmp"
dirList=". dnooLogs dnooStorage dnooHello dnooMain"

mvn clean 2>&1 >/dev/null

for theDir in $dirList
do
   if test -f "$theDir/$sourcePomFile"
   then
      cp $theDir/$sourcePomFile $theDir/$pomFile
   fi
done

mvn install

mvn pitmp:run 2>&1 | tee pitmp.traces
