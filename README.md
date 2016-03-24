# TODO

- [ ] vagrant deploy
- [ ] reject if blank
- [ ] delete phi from fixtures
- [ ] seed db
- [ ] delete program
- [ ] delete region
- [ ] change password

#Deployment

Copy `/bootstrap` to `/vagrant/bootstrap`

Copy deploy users's `id_rsa` and `id_rsa.pub` to `/vagrant/bootstrap`. 

Create a file  `/vagrant/bootstrap/local_env.yml` with the following content:

```
TWILIO_ACCOUNT_SID: 'your twilio SID'
TWILIO_AUTH_TOKEN: 'your twilio auth token'
TWILIO_NUMBER: 'your twilio number'
```
