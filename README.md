# Multi-Container Application Deployment on AWS EC2

## Objective

This project demonstrates the deployment of a two-tier web application (Flask + MySQL) on AWS EC2 using modern DevOps practices, including:

* Infrastructure as Code (Terraform)
* Configuration Management (Ansible)
* Containerization (Docker)
* Multi-container orchestration (Docker Compose)

---

## Architecture Overview

The system is deployed on a single AWS EC2 instance running a containerized environment.

```
AWS EC2 (Amazon Linux 2)
│
├── Docker Engine
│   ├── Flask Web Application (Port 5000 - Exposed)
│   └── MySQL Database (Port 3306 - Internal Only)
│
└── Docker Compose (Service Orchestration)

Provisioning: Terraform
Configuration: Ansible
```

---

## Infrastructure Layers

* Compute: AWS EC2 (t3.micro, Free Tier eligible)
* Operating System: Amazon Linux 2
* Infrastructure as Code: Terraform (v1.5+)
* Configuration Management: Ansible (v2.10+)
* Container Runtime: Docker (v25+) and Docker Compose (v2+)
* Remote State Management: AWS S3 + DynamoDB

---

## Project Structure

```
MultiContainerLab/
├── README.md
├── test.sh
├── ansible/
│   ├── ansible.cfg
│   ├── inventory.ini
│   └── playbook.yml
├── app/
│   ├── docker-compose.yml
│   ├── db/
│   │   └── init.sql
│   ├── web/
│   │   ├── Dockerfile
│   │   ├── app.py
│   │   ├── requirements.txt
│   │   └── .dockerignore
│   └── logs/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── backend_setup.tf
│   ├── inventory.tftpl
│   └── modules/
│       └── ec2/
└── evidence/
```

---

## Prerequisites

### Required Tools

| Tool           | Version  | Purpose                       |
| -------------- | -------- | ----------------------------- |
| Terraform      | v1.5+    | Infrastructure provisioning   |
| Ansible        | v2.10+   | Configuration management      |
| AWS CLI        | Latest   | AWS authentication            |
| Docker         | v25+     | Container runtime (EC2)       |
| Docker Compose | v2+      | Multi-container orchestration |
| curl           | Included | API testing                   |

### AWS Setup Requirements

* AWS account with Free Tier access
* Configured AWS CLI credentials
* EC2 SSH key pair in target region

---

## Deployment Workflow

### 1. Infrastructure Provisioning (Terraform)

```bash
cd terraform/
terraform init
terraform plan
terraform apply -auto-approve
```

Retrieve EC2 public IP:

```bash
terraform output -raw ec2_public_ip
```

---

### 2. Configuration Management (Ansible)

```bash
cd ../ansible/
cat inventory.ini
ansible-playbook -i inventory.ini playbook.yml
```

This installs and configures:

* Docker Engine
* Docker Compose
* Required system dependencies
* Application deployment

---

### 3. Application Deployment Verification

SSH into EC2:

```bash
ssh -i terraform/ec2-key.pem ec2-user@<EC2_PUBLIC_IP>
```

Check services:

```bash
docker --version
docker compose version
docker compose ps
docker compose logs web
```

---

## Local Testing (Optional)

Run application locally using Docker Compose:

```bash
cd app/
docker compose up -d
curl http://localhost:5000
docker compose down --volumes
```

---

## Application Details

### Flask Application

* Port: 5000
* Endpoints:

  * `GET /` → Health check
  * `GET /health` → System status
  * `GET /db` → Database connectivity test
  * `POST /api/data` → Data insertion

---

### MySQL Database

* Version: 5.7
* Internal port: 3306
* Credentials:

  * Username: root
  * Password: root
  * Database: mydb
* Schema initialized via `init.sql`

---

### Docker Compose Services

| Service | Description       | Port            |
| ------- | ----------------- | --------------- |
| web     | Flask application | 5000            |
| db      | MySQL database    | 3306 (internal) |

---

## Evidence / Screenshots

Include the following screenshots in the `evidence/` directory:

### 1. Docker Installation Verification

* Output of:

  * `docker --version`
  * `docker compose version`

### 2. Application Running

* Browser or curl response from:

  ```
  http://<EC2_PUBLIC_IP>:5000
  ```

### 3. Running Containers

* Output of:

  ```bash
  docker compose ps
  ```

### 4. Database Verification

* Output of:

  ```bash
  docker compose exec db mysql -uroot -proot -e "SELECT * FROM users;"
  ```

### 5. Deployment Logs

* Terraform apply logs
* Ansible playbook execution logs
* Docker container logs

### 6. Cleanup Verification

* Evidence showing:

  * Containers removed
  * EC2 instance terminated

---

## Cleanup Process

### Stop Containers (EC2)

```bash
cd /home/ec2-user/app
docker compose down --volumes
```

### Destroy AWS Infrastructure

```bash
cd terraform/
terraform destroy -auto-approve
```

---

## Troubleshooting

### Application Not Accessible

```bash
docker compose ps
docker compose logs web
```

Check AWS security group allows port 5000.

---

### Database Connection Issues

```bash
docker compose logs db
docker compose exec db mysql -uroot -proot -e "SELECT 1;"
```

---

### Build Issues

```bash
docker compose down -v
docker compose build --no-cache
```

---

### Terraform Issues

```bash
terraform validate
terraform fmt -recursive
terraform state list
```

---

## Key Concepts Demonstrated

* Infrastructure as Code using Terraform
* Configuration Management using Ansible
* Containerization using Docker
* Multi-container orchestration with Docker Compose
* Remote state management with S3 and DynamoDB
* Secure EC2 deployment on AWS
* Separation of application and database services

---

## Security Practices

* Restricted security group rules
* No public exposure of database port
* SSH key-based EC2 access
* Environment-based configuration for credentials
* Isolated Docker networking between services

## Auther 
**Kevin ISHIMWE**