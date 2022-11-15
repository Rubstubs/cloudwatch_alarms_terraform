resource "aws_cloudwatch_metric_alarm" "zerosum" {
  alarm_name                = "bank-sum-must-be-under-1000000"
  namespace                 = var.student_name
  metric_name               = "bank_sum.value"

  comparison_operator       = "GreaterThanThreshold"
  threshold                 = "1000000"
  evaluation_periods        = "2"
  period                    = "60"

  statistic                 = "Maximum"

  alarm_description         = "This alarm goes off as soon as the total amount of money in the bank exceeds ONE MILLION!"
  insufficient_data_actions = []
  alarm_actions       = [aws_sns_topic.user_updates.arn]
}

resource "aws_sns_topic" "user_updates" {
  name = var.student_name
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "email"
  endpoint  = "rubencarlsen@gmail.com"
}
