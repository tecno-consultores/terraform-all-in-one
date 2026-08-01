# Terraform All-in-One 🚀

[![Docker Pulls](https://img.shields.io/docker/pulls/sinfallas/terraform-all-in-one)](https://hub.docker.com/r/sinfallas/terraform-all-in-one)
[![Maintainer](https://img.shields.io/badge/Maintainer-Tecno%20Consultores%202023-blue)](https://www.tecnoconsultores.net/)

An Ubuntu-based Docker image designed for DevOps, CI/CD, and Infrastructure as Code (IaC) environments. It integrates essential tools into a single container, such as **Terraform**, **AWS CLI**, **Google Cloud CLI**, **Ansible**, and a graphical management interface via **SemaphoreUI**.

Additionally, the image includes a local cache of the AWS provider for Terraform, significantly speeding up project initialization.

---

## 🛠️ Included Tools & Packages

The container comes with the following pre-installed and ready-to-use tools:

* **Infrastructure & Cloud:** `terraform`, `awscli` (v2), `google-cloud-cli`, `ansible`.
* **Automation Interface:** `semaphoreui`.
* **Networking & Connectivity:** `ssh`, `sshpass`, `sshfs`, `samba-client`, `curl`, `wget`, `rsync`, `iputils-ping`.
* **System Utilities:** `git`, `jq`, `gnupg`, `tar`, `zip`, `unzip`, `nano`, `s3fs`, `swaks`, `expect`, `python3-pip`, `tzdata`, `software-properties-common`, `ca-certificates`.

---

## 🚀 Quick Start

### 1. Deployment with Docker Compose

The recommended way to deploy this environment is by using `docker-compose`.

Run the following command to start the container in the background:

```bash
docker compose up -d
```

### 2. Semaphore UI Access

Once the container is running, you can access the Semaphore web interface from your browser:

* **URL:** [http://127.0.0.1:3000](http://127.0.0.1:3000)
* **Default User:** `admin`
* **Default Password:** `0n0qNwFTHSMdd6i2m0xxukAuuVluppKD`

*(It is highly recommended to change the password after the first login).*

---

## ⚙️ Additional Configurations

### AWS Helper (`configuraraws`)
The image includes an internal script named `configuraraws` that automatically configures the AWS CLI using the injected environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_DEFAULT_REGION`). 
You can run it inside the container to quickly validate your credentials and identity (`sts get-caller-identity`).

### Pre-Downloaded AWS Provider
To save time and bandwidth, the container is pre-configured with the AWS provider in `/usr/local/share/terraform/plugins`. Terraform initializations (`terraform init`) for AWS projects will first check this local cache thanks to the configuration in `~/.terraformrc`.

### Recommended Volumes
* `/app` -> Working directory and SQLite/Semaphore data. Mounting this allows you to persist your CI/CD tasks configuration.
* `/recursos` -> A free-use directory to map scripts, SSH keys, or other files required for your deployments.

---

## 🤝 Support & Maintainer

* **Created by:** [Tecno Consultores 2023](https://www.tecnoconsultores.net/)
* **Maintainer:** Jesús Palencia (sinfallas@gmail.com)
* **License:** GPL-2
* **Docker Hub:** [sinfallas/terraform-all-in-one](https://hub.docker.com/r/sinfallas/terraform-all-in-one)
