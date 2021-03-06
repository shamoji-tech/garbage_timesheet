resource "google_cloud_scheduler_job" "slack-notify-scheduler-burnable" {

    name    = "slack-notify-burnable"
    project = var.project
    description = "燃えるゴミの日通知"
    schedule = "00 21 * * 0"
    time_zone = "Asia/Tokyo"

    pubsub_target {
        topic_name = google_pubsub_topic.slack_notify.id
        data       = base64encode("日曜日の9時になりました。明日は月曜日で燃えるゴミの日ですので、燃えるゴミを門の外に出しましょう。")
    }
}

resource "google_cloud_scheduler_job" "slack-notify-scheduler-burnable-2" {

    name    = "slack-notify-burnable-2"
    project = var.project
    description = "燃えるゴミの日通知(水曜版)"
    schedule = "00 21 * * 3"
    time_zone = "Asia/Tokyo"

    pubsub_target {
        topic_name = google_pubsub_topic.slack_notify.id
        data       = base64encode("水曜日の9時になりました。明日は木曜日で燃えるゴミの日ですので、燃えるゴミを門の外に出しましょう。")
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
        data       = base64encode("月曜日の9時になりました。明日は火曜日で資源ゴミの日です。段ボールとペットボトル、空き缶などを門のそとに出しましょう。")
    }
}

resource "google_cloud_scheduler_job" "slack-notify-scheduler-noburnable" {

    name    = "slack-notify-noburnable"
    project = var.project
    description = "燃えないゴミの日通知"
    schedule = "00 21 * * 5"
    time_zone = "Asia/Tokyo"

    pubsub_target {
        topic_name = google_pubsub_topic.friday_slack_notify.id
        data       = base64encode("金曜日の9時になりました。第2第4土曜日は燃えないゴミの日です。出すものがあれば、燃えないゴミを門のそとに出しましょう。")
    }
}