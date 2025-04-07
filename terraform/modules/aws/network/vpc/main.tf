resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  instance_tenancy     = var.instance_tenancy

  tags = merge(
    {
      Name = var.vpc_name
    },
    var.tags
  )
}

resource "aws_vpc_dhcp_options" "main" {
  domain_name_servers = var.domain_name_servers

  tags = merge(
      {
        Name = "${var.vpc_name}-dhcp-options"
      },
      var.tags
    )
  
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main.id
}