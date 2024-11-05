#!/bin/bash
sleep 10
mongoimport --drop --host mongodb --username admin --password password --authenticationDatabase admin --db tmdb_movies --collection movies -type json --file /data/seeding.json --jsonArray 