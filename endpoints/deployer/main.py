from cloudwatch_module import publish_status
from fargate_module import provision_ecs
from s3_module import get_size
import json


def handler(event, context):
    request_id = event['requestContext']['requestId']
    token = publish_status(request_id, 'RECEIVED', None)

    try:
        payload = json.loads(event['body'])
        task_size = get_size(payload['read_uri'])

        if (task_size == 'error'):
            raise AttributeError
        else:
            payload['request_id'] = request_id
            payload['token'] = token
            hex_body = json.dumps(payload).encode('utf-8').hex()
            provision_ecs(hex_body, task_size)

        output = {
            'statusCode': 200,
            'body': {'ACCEPTED': payload['request_id']}
        }

    except (KeyError, ValueError):
        output = {
            'statusCode': 400,
            'body': {'BAD_REQUEST': 'Invalid request parameters.'}
        }

    except AttributeError:
        output = {
            'statusCode': 400,
            'body': {'DENIED': 'Dataset size exceeds limit.'}
        }

    except Exception:
        output = {
            'statusCode': 500,
            'body': {'UNAVAILABLE': 'The service could not be provisioned.'}
        }

    message = list(output['body'].keys())[0]
    if (message != 'ACCEPTED'):
        publish_status(request_id, message, token)

    return output
