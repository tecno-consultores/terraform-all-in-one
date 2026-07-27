FROM ubuntu:26.04
LABEL maintainer="Jesus Palencia sinfallas@gmail.com"
LABEL build_date="2026-07-27"
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app
RUN apt update -qq && apt -y dist-upgrade && apt -y install --no-install-recommends --no-install-suggests jq ca-certificates gnupg software-properties-common tzdata git tar zip unzip s3fs ssh sshpass sshfs samba-client swaks nano wget curl rsync expect iputils-ping && apt clean && apt -y autoremove && rm -rf /var/lib/{apt,dpkg,cache,log} && rm -rf /var/cache/* && rm -rf /var/log/apt/* && rm -rf /tmp/*
# awscli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "/root/awscliv2.zip" && unzip /root/awscliv2.zip -d /root && /root/aws/install && rm -f /root/awscliv2.zip && rm -rf /root/aws
# terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com resolute main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update -qq && apt -y install --no-install-recommends --no-install-suggests terraform && touch ~/.bashrc && terraform -install-autocomplete
# gcloud cli
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt update -qq && apt -y install --no-install-recommends --no-install-suggests google-cloud-cli
# semaphore
RUN ARCH=$(dpkg --print-architecture) && LATEST_VERSION=$(curl -s https://api.github.com/repos/semaphoreui/semaphore/releases/latest | jq -r .tag_name | sed 's/^v//') && wget -P /tmp "https://github.com/semaphoreui/semaphore/releases/download/v${LATEST_VERSION}/semaphore_${LATEST_VERSION}_linux_${ARCH}.deb" && apt -y install "/tmp/semaphore_${LATEST_VERSION}_linux_${ARCH}.deb" && rm -f "/tmp/semaphore_${LATEST_VERSION}_linux_${ARCH}.deb" && apt clean && apt -y autoremove && rm -rf /var/lib/{apt,dpkg,cache,log} && rm -rf /var/cache/* && rm -rf /var/log/apt/* && rm -rf /tmp/*
