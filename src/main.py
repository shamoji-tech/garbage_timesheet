import calendar
import datetime
from dao.dao import SlackMessager,ExtractMessageFromPubSubContext,OSEnvironmentState

def send_message(context, info):
    
    webhook=OSEnvironmentState.getSlackWebhook()
    slackMessager=SlackMessager(webhook=webhook)
    message = ExtractMessageFromPubSubContext.messageDecode(context)
    
    slackMessager.send(message)
    
    print(context, info) #for logging

def is2nd4thSaturdayOnContext(context, info):
    
    if is2nd4thSaturday(datetime.date.today()):
        send_message(context, info)
    
    print(datetime.date.today(),is2nd4thSaturday(datetime.date.today()))


def is2nd4thSaturday(today: datetime.date) -> bool:
    
    if today.weekday()==5 and numOfWeek(today) in [2,4]:
        return True
    else:
        return False 

def numOfWeek(today: datetime.date) -> int:
    return (today.day-1)//7+1