output "elb_dns_name" {
    value = module.product.elb_dns_name 
}

output "azs" {
  value = data.aws_availability_zones.az.names[*]
}