import boto3


def get_size(read_uri):
    """
    Calculates the dataset size and
    returns the proper task definition.
    """
    name, key = read_uri.replace("s3a://", "").split("/", 1)
    s3 = boto3.resource('s3')
    bucket = s3.Bucket(name)
    total_size = 0
    
    for entry in bucket.objects.filter(Prefix=key):
        total_size = total_size + entry.size
        
    size_in_mb = (total_size / 1048576)
    
    if (size_in_mb <= 3100 ):
        task_size = 'tiny'
    elif (size_in_mb <= 6200):
        task_size = 'small'
    elif (size_in_mb <= 12300):
        task_size = 'medium'
    elif (size_in_mb <= 18500):
        task_size = 'large'
    elif (size_in_mb <= 23100):
        task_size = 'xlarge'
    else:
        task_size = 'error'

    return task_size
