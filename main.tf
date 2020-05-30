resource "google_storage_bucket" "garbage-system-bucket" {
    name = "garbage_timesheet_bucket_general"
    location = "asia"
    project = var.project
}

resource "google_storage_bucket_object" "python_soucecode"{
    name = "slack_notice.py"
    source = "./slack_notice.py"
    bucket = google_storage_bucket.garbage-system-bucket.name
}

