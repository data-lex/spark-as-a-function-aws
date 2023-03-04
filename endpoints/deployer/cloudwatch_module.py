import boto3
import time


def publish_status(stream_id, status, token):
    """
    Logs the request reception.
    """
    client = boto3.client('logs')

    if (token == None):
        client.create_log_stream(
            logGroupName='/sparkf/api',
            logStreamName=stream_id
        )

        log_event = client.put_log_events(
            logGroupName='/sparkf/api',
            logStreamName=stream_id,
            logEvents=[
                {
                    'timestamp': (time.time_ns() + 500000) // 1000000,
                    'message': status
                }
            ]
        )

    else:
        log_event = client.put_log_events(
            logGroupName='/sparkf/api',
            logStreamName=stream_id,
            logEvents=[
                {
                    'timestamp': (time.time_ns() + 500000) // 1000000,
                    'message': status
                }
            ],
            sequenceToken=token
        )

    return log_event['nextSequenceToken']
