resource "aws_lb" "this" {
  count = 1

  name = "${local.system_name}-link"

  internal           = false
  load_balancer_type = "application"

  access_logs {
    bucket  = data.terraform_remote_state.log_alb.outputs.s3_bucket_this_id
    enabled = true
    prefix  = "${local.system_name}-link"
  }

  security_groups = [
    data.terraform_remote_state.network_main.outputs.security_group_web_id,
    data.terraform_remote_state.network_main.outputs.security_group_vpc_id
  ]

  subnets = [
    for s in data.terraform_remote_state.network_main.outputs.subnet_public : s.id
  ]

  tags = {
    Name = "${local.system_name}-link"
  }
}

resource "aws_lb_listener" "https" {
  count = 1

  certificate_arn   = aws_acm_certificate.root.arn
  load_balancer_arn = aws_lb.this[0].arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn
  }

  depends_on = [
    aws_acm_certificate_validation.root
  ]
}

resource "aws_lb_listener" "redirect_http_to_https" {
  count = 1

  load_balancer_arn = aws_lb.this[0].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}