#!/bin/sh
################################################################################
currentD=`pwd`

targetModules="$*"

pomFile="pom.xml"
fileExtension="pitmp_descartes"
sourcePomFile="pom.xml.$fileExtension"
dirList=". dnooLogs dnooStorage dnooHello dnooMain dnooIntegration"

debugOption=
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
   echo mvn $debugOption $shouldDisplayOption pitmp:run 2>&1 | tee -a $fileExtension.traces
   mvn $debugOption $shouldDisplayOption pitmp:run 2>&1 | tee -a $fileExtension.traces
else
   echo mvn $debugOption $shouldDisplayOption "-DtargetModules=$targetModules" pitmp:run 2>&1 | tee -a $fileExtension.traces
   mvn $debugOption $shouldDisplayOption "-DtargetModules=$targetModules" pitmp:run 2>&1 | tee -a $fileExtension.traces
fi

echo "######## `date +%T`" 2>&1 | tee -a $fileExtension.traces
