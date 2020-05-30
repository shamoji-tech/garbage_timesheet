resource "google_storage_bucket" "garbage-system-bucket" {
    name = "garbage_timesheet_bucket_general"
    location = "asia"
    project = var.project
}

resource "google_storage_bucket_object" "python_soucecode"{
    name = "functions.zip"
    source = "./functions.zip"
    bucket = google_storage_bucket.garbage-system-bucket.name
}

data "archive_file" "function_zip"{
    type = "zip"
    source_dir = "./src"
    output_path = "./functions.zip"
}

resource "google_cloudfunctions_function" "slack_function"{
    name = "slack-notify"
    description = "Slackにメッセージを通知"
    runtime = "python37"
    project = var.project
    entry_point = "main"

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

