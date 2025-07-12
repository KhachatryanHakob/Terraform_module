resource "aws_launch_template" "prod" {
    name_prefix          = var.name_prefix_prod
    //user_data          = filebase64("${path.module}/user_data.sh")
    security_group_names = [aws_security_group.sg.name]
    instance_type        = var.instance_type
    image_id             = var.image_id 
}

//resource "aws_launch_template" "staging" {
//    name_prefix          = var.name_prefix_staging
//    user_data            = filebase64("")
//    security_group_names = [aws_security_group.sg.name]
//    instance_type        = var.prod_instance_type
//    image_id             = var.image_id 
//}

resource "aws_autoscaling_group" "for_all" {
    name                      = var.asg_name
    min_size                  = var.asg_min_size
    max_size                  = var.asg_max_size
    health_check_grace_period = var.health_check_grace_period
    health_check_type         = var.health_check_type
    min_elb_capacity          = var.min_elb_capacity
    availability_zones         = var.azs 

    launch_template {
        id      = aws_launch_template.prod.id
        version = "$Latest"
    }

    dynamic "tag" {
        for_each = {
            Name      = "ACG"
            owner     = "Hakob and Arman"
            Terraform = true
        }

        content {
            key                 = tag.key
            value               = tag.value
            propagate_at_launch = true
        }
    }

}

resource "aws_lb" "proj" {
   name               = var.lb_name
   internal           = var.lb_internal
   load_balancer_type = var.laod_balancer_type
   security_groups    = [aws_security_group.sg.id]
   subnets            = var.subnets
}

resource "aws_lb_target_group" "proj" {
    name      = var.target_group_name
    port      = var.lb_port
    protocol  = var.lb_protocol
    vpc_id    = var.vpc_id   

    dynamic "health_check" {
        for_each = var.health_check
        content {
            path                = try(health_check.value["path"],"/")
            interval            = try(health_check.value["interval"], 30)
            timeout             = try(health_check.value["timeout"], 5)
            healthy_threshold   = try(health_check.value["healthy_threshold"], 3)
            unhealthy_threshold = try(health_check.value["unhealthy_threshold"], 2)
            matcher             = try(health_check.value["matcher"], "200")
        }
    }

    
}

resource "aws_lb_listener" "proj" {
    load_balancer_arn = aws_lb.proj.arn
    port = 80
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.proj.arn
    }
}



resource "aws_default_subnet" "az1" {
    availability_zone = var.azs[0]
}

resource "aws_default_subnet" "az2" {
    availability_zone = var.azs[1]
}

