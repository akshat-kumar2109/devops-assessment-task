resource "aws_subnet" "main" {
  count                   = length(var.subnet_configs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_configs[count.index].cidr_block
  availability_zone       = var.subnet_configs[count.index].availability_zone
  map_public_ip_on_launch = var.subnet_configs[count.index].is_public ? true : false

  tags = merge(
    {
      Name = var.subnet_configs[count.index].name
      Type = var.subnet_configs[count.index].is_public ? "Public" : "Private"
    },
    var.tags
  )
}