module "vpc" {
  source   = "./vpc"
  vpc_name = "social-vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "subnet" {
  source = "./subnet"
  vpc_id = module.vpc.vpc_id
  subnet_configs = [{
    name              = "social-subnet-a"
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    is_public         = true
  }]
}

module "security_group" {
  source              = "./security_group"
  security_group_name = "social-sg"
  vpc_id              = module.vpc.vpc_id

  ingress_rules = [
    {
      cidr_blocks = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      description = "Allow SSH"
    },
    {
      cidr_blocks = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      description = "Allow HTTP"
    },
    {
      cidr_blocks = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 3000
      to_port     = 3000
      description = "Allow Grafana access"
    },
    {
      cidr_blocks = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 5000
      to_port     = 5000
      description = "Allow Application Port (Custom)"
    },
    {
      cidr_blocks = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 9090
      to_port     = 9090
      description = "Allow Prometheus UI/API"
    },
    {
      cidr_blocks = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 3100
      to_port     = 3100
      description = "Allow Loki API"
    },
    {
      cidr_blocks = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 9100
      to_port     = 9100
      description = "Allow Node Exporter metrics"
    },
    {
      cidr_blocks = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 9080
      to_port     = 9080
      description = "Allow Promtail HTTP listener (optional)"
    }
  ]
}


module "route" {
  source = "./route"
  vpc_id = module.vpc.vpc_id
  route_tables = [{
    name      = "Direct all traffic to internet gateway"
    subnet_ids = module.subnet.subnet_ids
    routes = [{
      cidr_block = "0.0.0.0/0"
      gateway_id = module.gateway.internet_gateway_id
    }]
  }]
}

module "gateway" {
  source       = "./gateway"
  vpc_id       = module.vpc.vpc_id
  gateway_name = "social-igw"
}