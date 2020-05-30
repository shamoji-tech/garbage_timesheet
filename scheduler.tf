resource "google_cloud_scheduler_job" "slack-notify-scheduler-burnable" {

    name    = "slack-notify-burnable"
    project = var.project
    description = "燃えるゴミの日通知"
    schedule = "00 21 * * 0,3"
    time_zone = "Asia/Tokyo"

    pubsub_target {
        topic_name = google_pubsub_topic.slack_notify.id
        data       = base64encode("日曜日の9時になりました。明日は燃えるゴミの日ですので、燃えるゴミを門の外に出しましょう。")
    }
}

resource "google_cloud_scheduler_job" "slack-notify-scheduler-resource" {

    name    = "slack-notify-resource"
    project = var.project
    description = "資源ゴミの日通知"
    schedule = "00 21 * * 1"
    time_zone = "Asia/Tokyo"

    pubsub_target {
        topic_name = google_pubsub_topic.slack_notify.id
        data       = base64encode("月曜日の9時になりました。明日は資源ゴミの日です。段ボールとペットボトル、空き缶などを門のそとに出しましょう。")
    }
}

resource "google_cloud_scheduler_job" "slack-notify-scheduler-noburnable" {

    name    = "slack-notify-noburnable"
    project = var.project
    description = "燃えないゴミの日通知"
    schedule = "00 21 * * 5"
    time_zone = "Asia/Tokyo"

    pubsub_target {
        topic_name = google_pubsub_topic.slack_notify.id
        data       = base64encode("金曜日の9時になりました。第2第4土曜日は燃えないゴミの日です。該当する曜日の日であれば、空き瓶を門のそとに出しましょう。")
    }
}