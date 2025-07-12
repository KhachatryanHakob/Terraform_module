resource "aws_subnet" "subnet1" {
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.az.names[0]
}

resource "aws_subnet" "subnet2" {
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.az.names[1]
}

module "product" {
    source           = "./modul/project" 

    vpc_id           = data.aws_vpc.default.id
    image_id         = data.aws_ami.latest_ubuntu24.image_id
    instance_type    = "t2.micro"
    name_prefix_prod = "asg-lt"
    lb_protocol      = "HTTP"

    azs = [
        data.aws_availability_zones.az.names[0],
        data.aws_availability_zones.az.names[1] 
    ]

    subnets = [
      aws_subnet.subnet1.id,
      aws_subnet.subnet2.id
    ]  

    health_check = {
      default = { 
        path                = "/"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
        matcher             = "200"
        protocol            = "HTTP"
      }
    }
}