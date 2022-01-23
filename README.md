
CI/CD using bitbucket pipeline
by: reza yusuf merdekantara

- API : Golang

- Database : PostgreSQL

- Pipeline : bitbucket

- Container Repo : docker hub

- Server : AWS EC2

- Repository : https://github.com/rezamerdeka/stockbit.git

- Postman JSON : curl -X POST http://3.25.82.112:8080/items -H "Content-type: application/json" -d '{ "name": "stockbit-test", "description": "rezamerdeka"}'

- URL : http://3.25.82.112:8080/items


Answer for question point 2
##Underlying REST API
- Postman =  for testing parameters
- Kibana + APM = monitoring all process of transaction so we can analysis API performance 
- Docker = lightweight service
- Mysql = flexible

##Database Cluster##

Database replication using AWS RDS cluster would be better for availabilty and performance also create read write node
If using multizone, create different subnet between zone, and connect using vpc peering

##Security Groups##

Use whitelist IP for intranet/privat transaction
