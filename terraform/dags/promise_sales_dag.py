from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def load_data():
    print("Loading Promise Sales Data")

with DAG(
    dag_id="promise_sales_dag",
    start_date=datetime(2026, 1, 1),
    schedule=None,
    catchup=False,
) as dag:

    load_task = PythonOperator(
        task_id="load_sales_data",
        python_callable=load_data,
    )