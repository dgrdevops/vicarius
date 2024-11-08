import boto3

def create_ec2_instance(ami_id, subnet_id, instance_type="t3.micro"):
    ec2 = boto3.client('ec2')
    instance = ec2.run_instances(
        ImageId=ami_id,
        InstanceType=instance_type,
        SubnetId=subnet_id,
        MinCount=1,
        MaxCount=1
    )
    print("EC2 Instance created:", instance['Instances'][0]['InstanceId'])

create_ec2_instance(ami_id="ami-12345678", subnet_id="subnet-12345678")