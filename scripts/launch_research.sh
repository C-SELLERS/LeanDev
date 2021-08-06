# Realpath polyfill, notably absent macOS and some debian distros
absolute_path() {
  echo "$(cd "$(dirname "${1}")" && pwd)/$(basename "${1}")"
}

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Get build directory from args position 1, or use default
DEFAULT_BUILD_DIR="${SCRIPT_DIR}/../Lean/Launcher/bin/Debug/"
BUILD_DIR=${1:-$DEFAULT_BUILD_DIR}
BUILD_DIR=$(absolute_path "${BUILD_DIR}")

# Use our startup script for jupyter, needed to set runtime properly
mkdir -p /root/.ipython/profile_default/startup/
ln -s ${BUILD_DIR}/start.py /root/.ipython/profile_default/startup/start.py

#Add our build directory to python path for python kernel
export PYTHONPATH="${PYTHONPATH}:${BUILD_DIR}"

# Get data directory from args position 2, or use default
DEFAULT_DATA_DIR="${SCRIPT_DIR}/../Lean/Data"
DATA_DIR=${2:-$DEFAULT_DATA_DIR}
DATA_DIR=$(absolute_path "${DATA_DIR}")

#Get Notebook location from args position 3, or use default
DEFAULT_NOTEBOOK_DIR="${BUILD_DIR}/Notebooks"
NOTEBOOK_DIR=${3:-$DEFAULT_NOTEBOOK_DIR}
NOTEBOOK_DIR=$(absolute_path "${NOTEBOOK_DIR}")

#If the folder doesn't exist create it.
if [ ! -d "$NOTEBOOK_DIR" ]; then 
    echo "Creating Notebook Directory at $NOTEBOOK_DIR"
    mkdir $NOTEBOOK_DIR
fi

# If the config doesn't exist, create it
CONFIG=$NOTEBOOK_DIR/config.json
if [ ! -f "$CONFIG" ]; then 
    echo "Creating research config at $CONFIG"
    echo "{
    \"data-folder\": \"${DATA_DIR}\",
    \"composer-dll-directory\": \"${BUILD_DIR}\", 
    \"algorithm-language\": \"Python\",
    \"messaging-handler\": \"QuantConnect.Messaging.Messaging\", 
    \"job-queue-handler\": \"QuantConnect.Queues.JobQueue\", 
    \"map-file-provider\": \"QuantConnect.Data.Auxiliary.LocalDiskMapFileProvider\",
    \"factor-file-provider\": \"QuantConnect.Data.Auxiliary.LocalDiskFactorFileProvider\",
    \"data-provider\": \"QuantConnect.Lean.Engine.DataFeeds.DefaultDataProvider\",
    \"api-handler\": \"QuantConnect.Api.Api\", 
    \"job-user-id\": \"0\",
    \"api-access-token\": \"\",
    \"job-organization-id\": \"\",
}" > $CONFIG
fi

# Copy over any notebooks from research directory to notebook directory
RESEARCH_DIR=$(absolute_path "${SCRIPT_DIR}/../Lean/Research")
RESEARCH_FILES="${RESEARCH_DIR}/*.ipynb"
if [ -d "$RESEARCH_DIR" ]; then 
    echo "Copying research files from $RESEARCH_FILES to $NOTEBOOK_DIR; will not overwrite existing files"
    cp -n $RESEARCH_FILES $NOTEBOOK_DIR
fi

# Launch jupyter-lab
jupyter-lab --allow-root --no-browser --notebook-dir=$NOTEBOOK_DIR --LabApp.token='' 