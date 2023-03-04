def get_subnets():
    subnets = [
        'subnet-27e82841',
        'subnet-b00494fd',
        'subnet-698d4136',
        'subnet-cb3b2cf5',
        'subnet-04d5500a',
        'subnet-95b977b4'
    ]
    return subnets


def get_secgroups():
    security_groups = [
        'sg-b3892c91'
    ]
    return security_groups


def get_submission(hex_body):
    spark_submit = [
        'spark-submit',
        '--class', 'dp.sparkf.Runner',
        's3a://aws.settings/ecs/sparkf/runner.jar',
        '{}'.format(hex_body)
    ]
    return spark_submit
