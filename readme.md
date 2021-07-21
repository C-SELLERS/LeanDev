
# Lean Development Container

This repo aims to simplify local development of Lean by introducing a docker container development environment for VS Code. By building on top of the Lean Foundation image we are able to quickly setup an environment with all necessary dependencies installed already. Then with the customization settings in this repo we are able to add addition useful tools for development such as:

- Latest Git
- Pre-Installed VSCode Extensions
- Python Stubs for AutoComplete
- Research Support Py & C#
- Autobuilder task

# Setup

1. Get [Visual Studio Code](https://code.visualstudio.com/download)
    - Get [Remote Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) Extension

2. Get [Docker](https://docs.docker.com/get-docker/):
    - Follow the instructions for your Operating System
    - New to Docker? Try docker getting-started

3. Pull Lean’s latest foundation image from a terminal
    - _docker pull quantconnect/lean:foundation_


4. Open this directory in VSCode and do the following:
   - Ctrl + Shift + P to bring up VS Code command palette
   - Search for "Remote-Container: Rebuild and Reopen in Container"
   - Execute the command (Click or press enter)

From here the container should be initializing, this may take awhile as it acquires a copy of the latest Lean repo.

Once complete your environment is ready to go, a pop up should appear asking for you to open the workspace `lean.code-workspace`. If it doesn't go to File > Open Workspace > `lean.code-workspace`. Now you should Lean & Local directories in the workspace. You can expand the directories in the workspace by adding additional entries to the `lean.code-workspace` file, or in File > Add Folder to Workspace...

If you would like to mount local files to your container, checkout `devcontainer.json` "mounts" section for an example of a data mount! Upon any mount changes you must "rebuild" the container using Command Palette as in step 4.

# Running Lean

This works just like running Lean in vscode outside of the container, reference [readme](https://github.com/QuantConnect/Lean/tree/master/.vscode#how-to-use-lean) in Lean repo under .vscode.

# Environment updates

Updates to Lean foundation image may cause incompatibility issues. If you are experiencing problems running Lean be sure to update your foundation image. This can be done locally with the following command:
`docker pull quantconnect/lean:foundation`
Then use the "Rebuild and Reopen in Container" if local, or "Rebuild Container" if in dev container option from the command pallete to update to the latest environment. 
