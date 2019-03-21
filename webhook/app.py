import boto3
import json

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('botmakerd')

def respond(err, res=None):
    return {
        'statusCode': '400' if err else '200',
        'body': str(err) if err else json.dumps(res),
        'headers': {
            'Content-Type': 'application/json',
        },
    }

def lambda_handler(event, context):
    operation = event['httpMethod']
    if operation == "POST":
        payload = json.loads(event['body'])
        try:
            return respond(None, table.put_item(Item=payload))
        except Exception as e:
            return respond(e)
    else:
        return respond(ValueError('Unsupported method "{}"'.format(operation)))
