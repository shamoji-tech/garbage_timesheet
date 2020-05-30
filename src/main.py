import slackweb
import os
import base64
def main(context,context2):
    print(context,"1_type:",type(context),context["data"])
    slack=slackweb.Slack(url=os.environ["SLACK_WEBHOOK_URL"])
    bs64code=context["data"]
    send_text=base64.b64decode(bs64code).decode()
    slack.notify(text=send_text)
    print(send_text)
    


