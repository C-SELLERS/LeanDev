$FOLDER = "Workspaces/Lean/"
$URL = "https://github.com/QuantConnect/Lean"

# Try and clone Lean, will fail if directory exists and is not an empty dir
if ! git clone "${URL}" "${FOLDER}" 2>/dev/null && [ -d "${folder}" ] ; then
    echo "Clone failed because the folder ${folder} exists"
fi

# Add local packages source and restore our project
dotnet nuget add source /Workspaces/Lean/LocalPackages
dotnet restore /Workspaces/Lean/QuantConnect.Lean.sln
