from twilio.rest import Client
account = ".."
token = ".."
client = Client(account, token)

message = client.messages.create(to="..", from_="..",
                                 body="TRACKER HIT")

