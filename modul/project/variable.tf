    variable "service" {
        type        = string
        default     = ""
        description = "Description name "
    }

   # variable "region" {
    #    type        = string
    #    default     = "eu-central-1"
    #    description = "region for vpc"
    #}

    variable "ingress" {
        type        = list(any)
        default     = ["80", "443", "8443"]
        description = "ep"
    }

    variable "cidr_blocks" {
        type        = list(any)
        default     = ["0.0.0.0/0"]
        description = "CIDR acces"
    }

    variable "name_prefix_prod" {
        type        = string
        description = "It is used for proj launch template"
    }

    variable "instance_type" {
        type        = string
        description = "ec2 type"
    }

    variable "asg_name" {
        type        = string
        default     = "ASG"
        description = "ASG name"
    }

    variable "asg_min_size" {
        type        = number 
        default     = 1
        description = "Size for min inc"
    }

    variable "asg_max_size" {
        type        = number 
        default     = 1
        description = "Size for max inc"
    }

    variable "health_check_grace_period" {
        type        = number
        default     = 300
        description = "Health check grace period"
    }

    variable "health_check_type" {
        type        = string
        default     = "ELB"
        description = "Health Check Type"
    }

    variable "min_elb_capacity" {
        type        = number
        default     = 2
        description = "minimal capacity" 
    }

    variable "lb_name" {
        type        = string
        default     = "proj-lb"
        description = "lb name" 
    }

    variable "lb_internal" {
        type        = bool
        default     = false
        description = "lb internal"
    }

    variable "laod_balancer_type" {
        type        = string
        default     = "application"
        description = "lb type"
    }

    variable "subnets" {
        type = list(string)
    }

    variable "target_group_name" {
        type        = string
        default     = "project-target-group"
        description = "target group name" 
    }
    
    variable "lb_port" {
        type        = number
        default     = 80
        description = "port"
    }
    
    variable "lb_protocol" {
        type        = string
        default     = "HTTP"
        description = "port protocol"
    }

    variable "health_check" {
        type = map(object({
        healthy_threshold   = number
        unhealthy_threshold = number
        interval            = number
        protocol            = string
        path                = string
        timeout             = number
        matcher             = string
       }))
    }

    variable "azs" {
        description = "list of azs"
        type        = list(string)
    }

    variable "image_id" {
       type        = string
       description = "ami for ec2"
    }

    variable "vpc_id" {
        type        = string
        description = "vpc identifier"
    }