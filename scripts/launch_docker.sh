#!/bin/bash

#Point this to local path to Lean on your host device
LOCAL_HOME="/home/colton/work/LeanDev/Lean"
TIMENOW=$(date +"%Y_%m_%d_%I_%M_%p")
RESULTS="${LOCAL_HOME}/TestResults/${TIMENOW}"

docker run --rm \
    --mount type=bind,src=${LOCAL_HOME}/Launcher/config.json,target=/Lean/Launcher/config.json \
    --mount type=bind,src=${LOCAL_HOME}/Data,target=/Data/ \
    --mount type=bind,src=${LOCAL_HOME}/Algorithm.Python,target=/Lean/Algorithm.Python \
    --mount type=bind,src=${RESULTS},target=/Results \
    quantconnect/lean:latest \
    --data-folder /Data --results-destination-folder /Results --config /Lean/Launcher/config.json

    #If you want to store console logs in text in results file
    # &> ${RESULTS}/dockerlog.txt