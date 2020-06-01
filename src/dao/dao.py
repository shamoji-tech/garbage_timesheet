import slackweb
import base64
import os
class SlackMessager():
    def __init__(self,webhook:str):
        """ Slackに送信するメッセンジャー
        """
        self.messager = slackweb.Slack(url=webhook)

    def send(self,message:str):
        
        self.messager.notify(text=message)
        
    
class ExtractMessageFromPubSubContext():
    """ Pub/Subで送られてくるメッセージを解読してstrで返すクラス
    """
    @staticmethod
    def messageDecode(context:dict) -> str:
        base64data=context["data"]
        return base64.b64decode(base64data).decode()
        
class OSEnvironmentState():
    
    @staticmethod
    def getSlackWebhook() ->str:
        return os.environ["SLACK_WEBHOOK_URL"]