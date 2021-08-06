#!bin/bash
TIMENOW=$(date +"%Y_%m_%d_%I_%M_%p")
RESULTDIR="/Workspaces/Local/TestResults/${TIMENOW}/"

# Make the result directory if it doesn't already exist
if  [ ! -d "$RESULTDIR" ]; then
    mkdir $RESULTDIR
fi

# Run the test set, can use filter arg to select specifics
#--filter "FullyQualifiedName~PandasConverterTests"
dotnet test \
    --logger "trx;logfilename=testresult.xml" \
    --results-directory $RESULTDIR |& tee $RESULTDIR/testlog.txt


#--filter "StableBaselinesTest"
#BlazeTest