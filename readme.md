
# Lean Development Container

This repo aims to simplify local development with Lean by introducing a docker container development environmnent for VS Code. By building on top of the Lean Foundation image we are able to quickly setup an environment with all necessary dependencies are installed already. Then with the custom dockerfile and devcontainer settings in this repo we are able to add addition useful tools for development such as:

- Latest Git
- Python Stubs for AutoComplete
- Research Support
- Recommended VS Code Extensions

The eventual plan for this repo will be to merge directly into Lean to allow customization of the VS Code Launch configurations directly, but this may or may not happen. 

# Setup

Before going any further please [install docker](https://docs.docker.com/get-docker/) on your machine and ensure it is currently running.

From VSCode we can launch the development environment by using the "Remote-Containers" extension. It is likely you will be asked to install it upon opening the repo, but if not please install this extension from the marketplace. 

Once installed do the follow:
- Ctrl + Shift + P to bring up VS Code command palette
- Search for "Remote-Container: Rebuild and Reopen in Container"
- Execute the command (Click or press enter)

From here the container should be initializing, this may take awhile as it will download the Lean Foundation image as well as a copy of the latest repo.

Once complete your environment is ready to go, for now you will have to do most of the work from the command line until we overwrite the VS Code launch options.

# Commands
- `dotnet build`