
resource "google_cloudfunctions_function" "slack_function"{
    name = "slack-notify"
    description = "Slackにメッセージを通知"
    runtime = "python37"
    project = var.project
    entry_point = "send_message"
    region = var.region

    source_archive_bucket = google_storage_bucket.garbage-system-bucket.name
    source_archive_object = google_storage_bucket_object.python_soucecode.name

    environment_variables = {
        SLACK_WEBHOOK_URL = var.secret.url
    }

    event_trigger {
        event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
        resource   = google_pubsub_topic.slack_notify.name
    }
    service_account_email = "batchkickingaccount@general-259115.iam.gserviceaccount.com"
}

resource "google_pubsub_topic" "slack_notify" {
  name    = "slack-notify"
  project = var.project
}


resource "google_cloudfunctions_function" "fridayday_slack_function"{
    name = "slack-notify-friday"
    description = "Slackにメッセージを通知(不燃ごみバージョン→第2第4金曜のみ通知)"
    runtime = "python37"
    project = var.project
    entry_point = "is2nd4thFridayOnContext"
    region = var.region

    source_archive_bucket = google_storage_bucket.garbage-system-bucket.name
    source_archive_object = google_storage_bucket_object.python_soucecode.name

    environment_variables = {
        SLACK_WEBHOOK_URL = var.secret.url
    }

    event_trigger {
        event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
        resource   = google_pubsub_topic.friday_slack_notify.name
    }
    service_account_email = "batchkickingaccount@general-259115.iam.gserviceaccount.com"
}

resource "google_pubsub_topic" "friday_slack_notify" {
  name    = "slack-notify-friday"
  project = var.project
}

