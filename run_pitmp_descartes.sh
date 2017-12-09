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
shouldRunOption=
# shouldRunOption="-DshouldRunOnly=true"

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

if test "X$targetModules" = "X"
then
   mvn $debugOption $shouldRunOption pitmp:run 2>&1 | tee $fileExtension.traces
else
   mvn $debugOption $shouldRunOption "-DtargetModules=$targetModules" pitmp:run 2>&1 | tee $fileExtension.traces
fi
