import boto3
import json

def send_email(recipient, subject, body):
    # Create an SES client
    ses = boto3.client('ses', region_name='us-east-1')
    # Set the parameters for the email
    params = {
        'Destination': {
            'ToAddresses': [recipient]
        },
        'Message': {
            'Body': {
                'Text': {
                    'Charset': 'UTF-8',
                    'Data': body
                }
            },
            'Subject': {
                'Charset': 'UTF-8',
                'Data': subject
            }
        },
        'Source': 'abdelrhman.sayed.ibrahim@gmail.com'
    }
    # Send the email
    response = ses.send_email(**params)
    return response

def lambda_handler(event, context):
    recipient = 'abdelrhman.sayed.ibrahim@gmail.com'
    subject = 'Terraform State Changed!'
    body = 'There is a new change in the Terraform state.'
    response = send_email(recipient, subject, body)
    return {
        'statusCode': 200,
        'body': json.dumps("Email Sent Successfully. MessageId is: " + response['MessageId'])
    }