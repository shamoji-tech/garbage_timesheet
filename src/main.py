import slackweb
import os
import base64
def main(context,context2):
    print(context,context2)
    slack=slackweb.Slack(url=os.environ["SLACK_WEBHOOK_URL"])
    slack.notify(text=base64.b64decode(context["data"]))


