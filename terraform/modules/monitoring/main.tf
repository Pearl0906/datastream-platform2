resource "google_logging_metric" "dag_failure_metric" {
  name   = "dag_failure_metric"

  filter = <<EOT
resource.type="gce_instance"
severity>=ERROR OR textPayload:"ERROR"
EOT

  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
    unit        = "1"
  }
}
resource "google_monitoring_alert_policy" "pipeline_failure_alert" {
  display_name = "DataStream Pipeline Failure Alert"
  combiner     = "OR"

  depends_on = [
    google_logging_metric.dag_failure_metric
  ]

  conditions {
    display_name = "Failure detection"

    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/dag_failure_metric\" resource.type=\"gce_instance\""

      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }
}
