#!/bin/sh
################################################################################
currentD=`pwd`

pomFile="pom.xml"
fileExtension="pitmp_descartes"
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

mvn pitmp:run 2>&1 | tee $fileExtension.traces
