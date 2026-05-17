import logging
from flask import Flask
import time
import boto3
import datetime

app = Flask(__name__)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("devops-app")

s3 = boto3.client(
    "s3",
    endpoint_url="http://localstack:4566",
    aws_access_key_id="test",
    aws_secret_access_key="test",
    region_name="eu-west-1"
)

BUCKET = "devops-bucket"


@app.route("/")
def home():
    logger.info("Home endpoint called")
    return "DevOps Platform Running"


@app.route("/generate")
def generate():
    logger.info("Generate endpoint triggered")

    content = f"Log generated at {datetime.datetime.now()}"
    filename = f"log-{datetime.datetime.now().timestamp()}.txt"

    path = f"/tmp/{filename}"

    with open(path, "w") as f:
        f.write(content)

    s3.upload_file(path, BUCKET, filename)

    logger.info(f"File uploaded to S3: {filename}")

    return "OK"


@app.route("/error")
def error():
    logger.error("Manual error triggered")
    return "Error simulated", 500

def upload_with_retry(path, bucket, key, retries=5):
    for i in range(retries):
        try:
            upload_with_retry(path, BUCKET, filename)
            logger.info(f"Upload successful: {key}")
            return
        except Exception as e:
            logger.warning(f"Upload failed (attempt {i+1}): {e}")
            time.sleep(2)

    logger.error(f"Upload failed permanently: {key}")