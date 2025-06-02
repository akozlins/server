#

```
# add user
sudo docker-compose exec admin flask mailu user hostmaster $DOMAIN $PASSWORD
# delete user
sudo docker-compose exec admin flask mailu user-delete hostmaster@$DOMAIN
# add alias
sudo docker-compose exec admin flask mailu alias hostmaster $DOMAIN postmaster@$DOMAIN
```
