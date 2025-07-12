resource "aws_security_group" "sg" {
    name        = var.asg_name
    description = "for project"

    dynamic "ingress" {
        for_each = var.ingress
        content {
            from_port  = ingress.value
            to_port    = ingress.value
            protocol   = "tcp"
            cidr_blocks = var.cidr_blocks
        }
    }

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks =["0.0.0.0/0"]
    }  

}      