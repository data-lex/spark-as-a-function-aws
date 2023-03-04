import boto3
import json
import time
from datetime import datetime


def handler(event, context):
    try:
        cwl_client = boto3.client('logs')
        payload = json.loads(event['body'])

        query = cwl_client.get_log_events(
            logGroupName='/sparkf/api',
            logStreamName=payload['request_id'],
            startTime=((time.time_ns() + 500000) // 1000000) - 432000000,
            endTime=(time.time_ns() + 500000) // 1000000,
            limit=1,
            startFromHead=False
        )

        result = query['events'][0]
        message = result['message']
        timestamp = str(datetime.fromtimestamp(result['timestamp'] // 1000))
        body = {'message': message, 'timestamp': timestamp}

        response = {
            'statusCode': 200,
            'body': json.dumps(body)
        }

    except:
        response = {
            'statusCode': 400,
            'body': 'Missing or invalid parameters.'
        }

    return response
