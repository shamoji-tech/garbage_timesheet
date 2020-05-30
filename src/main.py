import slackweb
import os
import base64
from dao.dao import SlackMessager,ExtractMessageFromPubSubContext,OSEnvironmentState

def send_message(context, info):
    
    webhook=OSEnvironmentState.getSlackWebhook()
    slackMessager=SlackMessager(webhook=webhook)
    message = ExtractMessageFromPubSubContext.messageDecode(context)
    
    slackMessager.send(message)
    
    print(context, info) #for logging