#!/bin/sh
################################################################################
currentD=`pwd`

if test "X$1" = "X"
then
   outputFormat="HTML"
else
   outputFormat="$1"
fi

pomFile="pom.xml"
sourcePomFile="pom.xml.pitest"
dirList=". dnooLogs dnooStorage dnooHello dnooMain dnooIntegration dnooNoTest"
fileExtension="pitest"

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

echo mvn org.pitest:pitest-maven:mutationCoverage "-DoutputFormats=$outputFormat" 2>&1 | tee -a $fileExtension.traces
mvn org.pitest:pitest-maven:mutationCoverage "-DoutputFormats=$outputFormat" 2>&1 | tee -a $fileExtension.traces

echo "######## `date +%T`" 2>&1 | tee -a $fileExtension.traces
