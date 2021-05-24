# ecs.tf

resource "aws_ecs_cluster" "cluster" {
  name = "${var.campaign_prefix}-${var.campaign_name}-cluster"
}

data "template_file" "nmap_task_definition" {
  template = file("templates/nmap_task_definition.template")

  vars = {
  campaign_id = "${var.campaign_prefix}-${var.campaign_name}"
  aws_region = var.aws_region
  }
}

resource "aws_ecs_task_definition" "nmap" {
  family                = "nmap"
  execution_role_arn    = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn         = aws_iam_role.ecs_task_role.arn
  network_mode          = "awsvpc"
  container_definitions = data.template_file.nmap_task_definition.rendered
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 512
  tags                     = {
    campaign_id = "${var.campaign_prefix}-${var.campaign_name}"
    name        = "nmap"
  }
}

data "template_file" "metasploit_task_definition" {
  template = file("templates/metasploit_task_definition.template")

  vars = {
  campaign_id = "${var.campaign_prefix}-${var.campaign_name}"
  aws_region = var.aws_region
  }
}

resource "aws_ecs_task_definition" "metasploit" {
  family                = "metasploit"
  execution_role_arn    = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn         = aws_iam_role.ecs_task_role.arn
  network_mode          = "awsvpc"
  container_definitions = data.template_file.metasploit_task_definition.rendered
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 512
  tags                     = {
    campaign_id = "${var.campaign_prefix}-${var.campaign_name}"
    name        = "metasploit"
  }
}