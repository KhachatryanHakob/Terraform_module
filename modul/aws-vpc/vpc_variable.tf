    variable "env" {
        type        = string
        default     = ""
        description = "Envoirment  type : prod | dev"
    }

    variable "database_subnet_cidrs" {
        default = [
        "10.10.231.0/24",                           
        "10.10.232.0/24"    
        ]
    description = "database cider"
    }

    variable "private_subner_cidrs" {
        default = [
        "10.10.251.0/24",
        "10.10.252.0/24",
        "10.10.253.0/24",
        "10.10.254.0/24"
         ]
        description = "cider blok for private subnet"
    }

    variable "public_subnet_cidrs" {
        default = [
        "10.10.241.0/24",
        "10.10.242.0/24",
        "10.10.243.0/24",
        "10.10.244.0/24"
        ]
    description = "cider blok for public subnet"
    }

    variable "vpc_scidr" {
        default     = "10.10.0.0/16"
        escription  = "Cider block for VPC"
    }