from airflow import DAG
from datetime import datetime
import os
import sys

from airflow.operators.python import PythonOperator
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipelines.reddit_pipeline import reddit_pipeline


default_args = {
    'owner': 'João Renato',
    'start_date': datetime(2025, 5, 10)
}

file_postfix = datetime.now().strftime("%Y%m%d")

dag = DAG(
    dag_id='etl_reddit_pipeline',
    default_args=default_args,
    schedule_interval='@daily',
    catchup=False,
    tags=['reddit', 'pipeline', 'etl']
)

# Extract info from Reddit
extract = PythonOperator(
    task_id = 'reddit_extraction',
    python_callable=reddit_pipeline,
    op_kwargs = {
        'subreddit': 'brdev',
        'time_filter': 'day',
        'limit': 100
    },
    provide_context=True,
    dag=dag
)

# Upload to S3


extract