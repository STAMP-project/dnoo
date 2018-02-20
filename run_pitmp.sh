#!/bin/sh
################################################################################
printUsage()
{
   echo "Usage: $ScriptName [-t <targetModules> |-s <skippedModules> }"
}

################################################################################
usage()
{
   printUsage
   exit 1
}

################################################################################
targetModules=""
skippedModules=""
while test ! "X$1" = "X"
do
   if test "$1" = "-t"
   then
      if test "X$2" = "X"
      then
         usage
      else
         targetModules="-DtargetModules=$2"
         shift
      fi
   elif test "$1" = "-s"
   then
      if test "X$2" = "X"
      then
         usage
      else
         skippedModules="-DskippedModules=$2"
         shift
      fi
   else
      usage
   fi
   shift
done

pomFile="pom.xml"
fileExtension="pitmp"
sourcePomFile="pom.xml.$fileExtension"
dirList=". dnooLogs dnooStorage dnooHello dnooMain dnooIntegration"

# debugOption=
debugOption="-e"
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

echo "mvn $debugOption $shouldDisplayOption $targetModules $skippedModules pitmp:run" | tee -a $fileExtension.traces
mvn $debugOption $shouldDisplayOption $targetModules $skippedModules pitmp:run 2>&1 | tee -a $fileExtension.traces

echo "######## `date +%T`" 2>&1 | tee -a $fileExtension.traces
