ecs_instance_role_name = "ecs_instance_role"
ecs_instance_role = "ecs_instance_role"
policy_arn         = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
aws_batch_service_role_policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
main_cidr_block = "10.1.0.0/16"
main1_cidr_block = "10.1.0.0/24"
sg_allow_name = "sg_allow"
description = "Allow TLS inbound traffic"
ingress_description = "TLS from VPC"
ingress_from_port = 443
ingress_to_port = 443
ingress_protocol = "tcp"
egress_from_port = 0
egress_to_port = 0
egress_protocol = -1
egress_cidr_blocks =["0.0.0.0/0"]
sample_name = "sample"
max_vcpus = 16
type = "FARGATE"
service_type = "MANAGED"
state = "ENABLED"
ecs_task_execution_role_name = "tf_test_batch_exec_role"
ecs_task_execution_role_policy_arn=  "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
test_name = "tf_test_batch_job_definition"
test_type = "container"
platform_capabilities = ["FARGATE"]
test_queue_name = "tf-test-batch-job-queue"
# state = "ENABLED"
aws_batch_scheduling_policy_name = "example"


 