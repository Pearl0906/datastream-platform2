output "alert_policy_name" {
  value = google_monitoring_alert_policy.pipeline_failure_alert.display_name
}