# 📦 de_reddit_pipeline_aws

Data engineering pipeline to collect, process, and store Reddit data using AWS services such as Glue, S3, and Athena providing resources with Terraform.

## 🚀 Overview

This project implements an ETL (Extract, Transform, Load) pipeline that:

- Extracts data from the Reddit API.
- Processes and transforms the data using AWS Glue.
- Stores the raw and processed data in Amazon S3.
- Automates infrastructure with Terraform.
- Orchestrates tasks with Apache Airflow.

## 🧱 Architecture

1. **Extraction**: Python scripts collect data from specific Reddit subreddits.
2. **Transformation**: AWS Glue processes the raw data.
3. **Loading**: Transformed data is stored in Amazon S3 in Parquet format.
4. **Orchestration**: Apache Airflow manages task execution from API ETL.
5. **Infrastructure as Code**: Terraform provisions the necessary AWS resources.

## 🗂️ Project Structure

```
de_reddit_pipeline_aws/
├── aws_glue/           # AWS Glue job scripts
├── config/             # Configuration files
├── dags/               # Airflow DAGs
├── etls/               # ETL scripts
├── pipelines/          # Pipeline definitions
├── data/               # Collected Reddit data
├── terraform/          # Terraform provisioning scripts
├── utils/              # Utility functions
├── Dockerfile          # Environment Dockerfile
├── docker-compose.yml  # Docker Compose for local orchestration
├── requirements.txt    # Python dependencies
└── README.md           # Project documentation
```

## 🛠️ Technologies Used

- **AWS Glue**: Data processing and transformation.
- **Amazon S3**: Data storage.
- **AWS Athena**: Queries the transformed output for analysis.
- **Terraform**: Infrastructure provisioning.
- **Apache Airflow**: Task orchestration.
- **Docker**: Containerized environment.
- **Python**: Main programming language.

## ⚙️ Prerequisites

- AWS account with appropriate permissions.
- [AWS CLI](https://aws.amazon.com/cli/) configured.
- [Terraform](https://www.terraform.io/) installed.
- [Docker](https://www.docker.com/) and Docker Compose installed.
- [Python 3.8+](https://www.python.org/downloads/) installed.

## 🚀 How to Run

1. **Clone the repository**:
    
    ```bash
    bash
    git clone https://github.com/rmendes1/de_reddit_pipeline_aws.git
    cd de_reddit_pipeline_aws
    
    ```
    
2. **Set environment variables**:
    
    Create a `.env` file with the following variables:
    
    ```env
    AWS_ACCESS_KEY_ID={YOUR_ACCESS_KEY}
    AWS_SECRET_ACCESS_KEY={YOUR_SECRET_ACCESS_KEY}
    AWS_DEFAULT_REGION={YOUR_REGION}
    
    ```
   
    Also set for Airflow environment:
3. 
    ```env
    AIRFLOW__CORE__EXECUTOR=CeleryExecutor
    AIRFLOW__CELERY__BROKER_URL={YOUR_REDIS_URL}
    AIRFLOW__CELERY__RESULT_BACKEND=db+postgresql://postgres:{YOUR_DB_URL}
    AIRFLOW__DATABASE__SQL_ALCHEMY_CONN=postgresql+psycopg2://postgres:{YOUR_DB_URL}
    AIRFLOW__CORE__FERNET_KEY={FERNET_KEY}
    AIRFLOW__CORE__LOGGING_LEVEL=INFO
    AIRFLOW__CORE__LOAD_EXAMPLES=False
    AIRFLOW_UID={YOUR_UID}
    ```
    
    
3. **Provision infrastructure using Terraform**:
    
    ```bash
    cd terraform
    terraform init
    terraform apply
    
    ```
    
4. **Build and run Docker containers**:
    
    ```bash
    CopiarEditar
    docker-compose up --build -d
    
    ```
    
5. **Access Airflow**:
    
    Open your browser and go to `http://localhost:8080` to manage your DAGs.
