import boto3
from fargate_parameters import *


def provision_ecs(hex_body, task_size):
    """
    Creates and executes a new
    Spark job via AWS Fargate.
    """
    client = boto3.client('ecs')
    client.run_task(
        cluster='sparkf_test',
        launchType='FARGATE',
        taskDefinition='sparkf_{}_test:3'.format(task_size),
        networkConfiguration={
            'awsvpcConfiguration': {
                'subnets': get_subnets(),
                'securityGroups': get_secgroups(),
                'assignPublicIp': 'DISABLED'
            }
        },
        overrides={
            'containerOverrides': [
                {
                    'name': 'sparkf',
                    'command': get_submission(hex_body)
                }
            ]
        }
    )
