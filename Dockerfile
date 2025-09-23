# Dockerfile - wisecow (updated)
FROM ubuntu:22.04

# avoid interactive prompts during apt installs
ENV DEBIAN_FRONTEND=noninteractive

# ensure executables under /usr/games are found
ENV PATH="/usr/games:${PATH}"

# enable universe (adds safety for fortune-mod/cowsay) and install packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common ca-certificates gnupg2 apt-transport-https && \
    # enable universe repo (add-apt-repository lives in software-properties-common)
    add-apt-repository universe || true && \
    apt-get update && \
    apt-get install -y --no-install-recommends cowsay fortune-mod fortunes netcat && \
    # cleanup to keep image small
    rm -rf /var/lib/apt/lists/*

# copy the script and make executable
COPY wisecow.sh /wisecow.sh
RUN chmod +x /wisecow.sh

EXPOSE 4499

ENTRYPOINT ["bash", "/wisecow.sh"]
