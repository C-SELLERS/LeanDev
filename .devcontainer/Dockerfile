# Use Lean Foundation as the base
FROM quantconnect/lean:foundation

# Update git to latest, enables features such as stashing individual files
RUN add-apt-repository -y ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y git

# Install useful pip packages
RUN pip install --no-cache-dir      \
    ptvsd                           \
    quantconnect-stubs

# Install dos2unix utility for converting pesky windows formatting when needed
RUN apt-get install -y dos2unix

# ------ Research Specific Setup ------
# Install clr-loader for running Py research in VS code
RUN pip install clr-loader==0.1.6
ENV LD_LIBRARY_PATH=/lib/

# Install .NET Interactive to support C# in Jupyter notebooks
ENV PATH="${PATH}:/root/.dotnet/tools"
RUN dotnet tool install -g --add-source "https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-tools/nuget/v3/index.json" Microsoft.dotnet-interactive --version 1.0.240403 && \
    dotnet interactive jupyter install 

# --------- Docker in Docker ---------
# Install Docker CE CLI
RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates curl gnupg2 lsb-release \
    && curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
    && echo "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce-cli

# Install Docker Compose
RUN export LATEST_COMPOSE_VERSION=$(curl -sSL "https://api.github.com/repos/docker/compose/releases/latest" | grep -o -P '(?<="tag_name": ").+(?=")') \
    && curl -sSL "https://github.com/docker/compose/releases/download/${LATEST_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose 