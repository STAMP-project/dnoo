#!/bin/sh
################################################################################
# $1 = outputFormat : XML | HTML | CSV
currentDir=`pwd`

if test "X$1" = "X"
then
   outputFormat="HTML"
else
   outputFormat="$1"
   shift
fi

targetModules="$*"

pomFile="pom.xml"
fileExtension="pitmp_descartes"
sourcePomFile="pom.xml.$fileExtension"
dirList=". dnooLogs dnooStorage dnooHello dnooMain dnooIntegration dnooNoTest"

debugOption=
# debugOption="-e -X"
# debugOption="-e"

shouldDisplayOption=
# shouldDisplayOption="-DshouldDisplayOnly=true"

mvn clean 2>&1 >/dev/null

# use the correct pom files
for theDir in $dirList
do
   if test -f "$theDir/$sourcePomFile"
   then
      cp $theDir/$sourcePomFile $theDir/$pomFile
   fi
done

mvn install 2>&1 >/dev/null

echo "######## `date +%T`" 2>&1 | tee $fileExtension.traces

if test "X$targetModules" = "X"
then
   echo mvn $debugOption $shouldDisplayOption pitmp:run "-DoutputFormats=$outputFormat" 2>&1 | tee -a $fileExtension.traces
   mvn $debugOption $shouldDisplayOption pitmp:run "-DoutputFormats=$outputFormat" 2>&1 | tee -a $fileExtension.traces
else
   echo mvn $debugOption $shouldDisplayOption "-DtargetModules=$targetModules" pitmp:run "-DoutputFormats=$outputFormat" 2>&1 | tee -a $fileExtension.traces
   mvn $debugOption $shouldDisplayOption "-DtargetModules=$targetModules" pitmp:run "-DoutputFormats=$outputFormat" 2>&1 | tee -a $fileExtension.traces
fi

echo "######## `date +%T`" 2>&1 | tee -a $fileExtension.traces
