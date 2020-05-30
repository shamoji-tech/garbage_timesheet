import slackweb
import os
def main(context):
    slack=slackweb.Slack(url=os.environ["SLACK_WEBHOOK_URL"])
    slack.notify(text="test")

