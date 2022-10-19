variable "ecs_instance_role_name" {
  description = "Name of the repository"
  type        = string
}

variable "policy_arn" {
  description = "The Amazon Resource Name of the scheduling policy"
  type        = string
}



variable "aws_batch_service_role_policy_arn" {
  description = "The Amazon ECS instance role applied to Amazon EC2 instances in a compute environment"
  type        = string
}

variable "main_cidr_block" {
  description = "Cidr block of the desired VPC"
  type        = string
}
variable "main1_cidr_block" {
  description = "Cidr block of the desired VPC"
  type        = string
}
variable "sg_allow_name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Name of the security group"
  type        = string
}

variable "ingress_description" {
  description = " Description of this ingress rule"
  type        = string
}

variable "ingress_from_port" {
  description = "Start port"
  type        = number
}

variable "ingress_to_port" {
  description = "End range port"
  type        = number
}

variable "ingress_protocol" {
  description = "Protocol"
  type        = string
}

variable "egress_from_port" {
  description = "Start port "
  type        = number
}

variable "egress_to_port" {
  description = "End port "
  type        = number
}

variable "egress_protocol" {
  description = "Protocol "
  type        = string
}

variable "egress_cidr_blocks" {
  description = "List of CIDR blocks "
  type        = list(string)
}

# variable "tags_name" {
#   description = "Map of tags to assign to the resource"
#   type        = string
# }

variable "sample_name" {
  description = "The name for your compute environment"
  type        = string
}

variable "max_vcpus" {
  description = "The minimum number of EC2 vCPUs that an environment should maintain"
  type        = number
}

variable "type" {
  description = "The type of compute environment"
  type        = string
}

variable "service_type" {
  description = "Key-value map of resource tags"
  type        = string
}

variable "state" {
  description = "The state of the compute environment"
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "Name of the role policy"
  type        = string
}

variable "ecs_task_execution_role_policy_arn" {
  description = "Policy document as a JSON formatted string"
  type        = string
}

variable "test_name" {
  description = " Specifies the name of the job definition"
  type        = string
}

variable "test_type" {
  description = " The type of job definition"
  type        = string
}

variable "platform_capabilities" {
  description = "The platform capabilities required by the job definition"
  type        = list(string)
}

variable "test_queue_name" {
  description = " Specifies the name of the job queue"
  type        = string
}


# variable "state" {
#   description = "The state of the job queue "
#   type        = string
# }
variable "aws_batch_scheduling_policy_name" {
  description = "Specifies the name of the scheduling policy"
  type        = string
}
