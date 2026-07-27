FROM ubuntu:26.04
LABEL maintainer="Jesus Palencia sinfallas@gmail.com"
LABEL build_date="2026-07-27"
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app
RUN apt update -qq && apt -y dist-upgrade && apt -y install --no-install-recommends --no-install-suggests ansible jq ca-certificates gnupg software-properties-common tzdata git tar zip unzip s3fs ssh sshpass sshfs samba-client swaks nano wget curl rsync expect iputils-ping python3-pip && apt clean && apt -y autoremove && rm -rf /var/lib/{apt,dpkg,cache,log} && rm -rf /var/cache/* && rm -rf /var/log/apt/* && rm -rf /tmp/*
# awscli install
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "/root/awscliv2.zip" && unzip /root/awscliv2.zip -d /root && /root/aws/install && rm -f /root/awscliv2.zip && rm -rf /root/aws
# terraform repo
RUN curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
# google cloud cli repo
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list
# terraform and gcloud install
RUN apt update -qq && apt -y install --no-install-recommends --no-install-suggests google-cloud-cli terraform && touch ~/.bashrc && terraform -install-autocomplete && apt clean && apt -y autoremove && rm -rf /var/lib/{apt,dpkg,cache,log} && rm -rf /var/cache/* && rm -rf /var/log/apt/* && rm -rf /tmp/*
# semaphore install
RUN ARCH=$(dpkg --print-architecture) && LATEST_VERSION=$(curl -s https://api.github.com/repos/semaphoreui/semaphore/releases/latest | jq -r .tag_name | sed 's/^v//') && wget -P /tmp "https://github.com/semaphoreui/semaphore/releases/download/v${LATEST_VERSION}/semaphore_${LATEST_VERSION}_linux_${ARCH}.deb" && apt -y install "/tmp/semaphore_${LATEST_VERSION}_linux_${ARCH}.deb" && rm -f "/tmp/semaphore_${LATEST_VERSION}_linux_${ARCH}.deb" && apt clean && apt -y autoremove && rm -rf /var/lib/{apt,dpkg,cache,log} && rm -rf /var/cache/* && rm -rf /var/log/apt/* && rm -rf /tmp/*
# misc
COPY configuraraws /usr/bin/configuraraws
RUN chmod 777 /usr/bin/configuraraws
RUN mkdir -p /etc/semaphore
COPY config.json /etc/semaphore/config.json
EXPOSE 3000
ENTRYPOINT ["semaphore", "server", "--config", "/etc/semaphore/config.json"]
