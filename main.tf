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
