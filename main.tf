resource "aws_iam_role" "ecs_instance_role" {
  name = var.ecs_instance_role_name

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
            "Service": "ec2.amazonaws.com"
        }
    }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = var.policy_arn
}

resource "aws_iam_instance_profile" "ecs_instance_role" {
  name = var.ecs_instance_role_name
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_role" "aws_batch_service_role" {
  name = "aws_batch_service_role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
        "Service": "batch.amazonaws.com"
        }
    }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "aws_batch_service_role" {
  role       = aws_iam_role.aws_batch_service_role.name
  policy_arn = var.aws_batch_service_role_policy_arn

}


resource "aws_vpc" "main" {
  cidr_block = var.main_cidr_block
}

resource "aws_subnet" "main1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.main1_cidr_block
}
resource "aws_security_group" "sg_allow" {
  name        = var.sg_allow_name
  description = var.description
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = var.ingress_description
    from_port        = var.ingress_from_port
    to_port          = var.ingress_to_port
    protocol         = var.ingress_protocol
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port        = var.egress_from_port
    to_port          = var.egress_to_port
    protocol         = var.egress_protocol
    cidr_blocks      = var.egress_cidr_blocks
  }

  tags = {
    Name = "sg_allow"
  }
}

resource "aws_batch_compute_environment" "sample" {
  compute_environment_name = var.sample_name

  compute_resources {
    max_vcpus = var.max_vcpus

    security_group_ids = [
      aws_security_group.sg_allow.id
    ]

    subnets = [aws_subnet.main1.id]

    type = var.type
  }

  service_role = aws_iam_role.aws_batch_service_role.arn
  type         = var.service_type
  depends_on   = [aws_iam_role_policy_attachment.aws_batch_service_role]
  state = var.state
 

}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = var.ecs_task_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = var.ecs_task_execution_role_policy_arn
}

resource "aws_batch_job_definition" "test" {
  name = var.test_name
  type = var.test_type
  platform_capabilities = var.platform_capabilities

  container_properties = <<CONTAINER_PROPERTIES
{
  "command": ["echo", "test"],
  "image": "busybox",
  "fargatePlatformConfiguration": {
    "platformVersion": "LATEST"
  },
  "resourceRequirements": [
    {"type": "VCPU", "value": "0.25"},
    {"type": "MEMORY", "value": "512"}
  ],
  "executionRoleArn": "${aws_iam_role.ecs_task_execution_role.arn}"
}
CONTAINER_PROPERTIES
}


resource "aws_batch_job_queue" "test_queue" {
  name     = var.test_queue_name
  state    = var.state
  priority = 1
  compute_environments = [aws_batch_compute_environment.sample.arn]
}


resource "aws_batch_scheduling_policy" "example" {
  name = var.aws_batch_scheduling_policy_name

  fair_share_policy {
    compute_reservation = 1
    share_decay_seconds = 3600

    share_distribution {
      share_identifier = "A1*"
      weight_factor    = 0.1
    }

    share_distribution {
      share_identifier = "A2"
      weight_factor    = 0.2
    }
  }

  tags = {
    "Name" = "Example Batch Scheduling Policy"
  }
}