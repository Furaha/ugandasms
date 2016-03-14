# TODO

- [ ] seed db
- [ ] delete program
- [ ] delete region
- [ ] change password

## Installation Instructions

Inorder to get this Up and Running

1. You need to create a file under the config directory `config/local_env.yml`

File Content

```
TWILIO_ACCOUNT_SID: 'your twilio SID'
TWILIO_AUTH_TOKEN: 'your twilio auth token'
TWILIO_NUMBER: 'your twilio number'
```

This is all you need to be able to send texts

However you need to set up a number for recieving and sending texts(i.e the user)

2. inorder for you twilio account to recieve texts


please follow this instructions

1. Go to Your Twilio Developer account
2. Under Products, Select Phone Numbers
3. Select The Phone Number You Want To Recieve Texts On
4. Click That Phone Number
5. Under Messaging, Fill in The Request URL with the url for receiving Texts in your App
