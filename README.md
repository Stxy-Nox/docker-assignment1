## Docker Assignment - Agile Software Practice.

__Name:__ 20108800 Shuobin Wang

__Demo :__ https://youtu.be/-nqIC6s18tc 

This repository contains the containerization of the mukti-container application illustrated below.

![](./images/arch.png)

### Network Isolation

Given that the architecture of the app is a chain where only adjacent pairs can communicate, I have set up three networks:

- `api-network`: connects the API and Redis.
- `mongo-network`: connects the API and MongoDB( and mongo_seeder, to seeding data.)
- `express-network`: connects MongoDB and Mongo Express.

### Database Seeding.

Given that all the data files are stored in `seeding.json`, I built a `mongo_seeder` image to copy `seeding.json` into the MongoDB container and to execute the `start.sh` script. The `start.sh` script is responsible for inserting data from the JSON file into the database, which is preset to be named `tmdb_movies` with a collection called `movies`. 

To build the `mongo_seeder` image, execute the following command:

```
docker build -f Dockerfile -t mongo_seeder .
```

This process mainly follows this tutorial: https://www.tonic.ai/blog/dockerizing-and-seeding-your-development-mongodb-database

### Multi-Stack.

To differentiate between production and development environments, I set the profiles for the seeder and mongo-express to `dev`, so the default startup acts as the production environment, containing only the movie-api, mongo, and redis, with no data pre-filled in the database. To start in production mode, use the following command:

```
docker-compose -f docker-compose.yml up -d
```

To start the development environment, use this command:

```
docker-compose -f docker-compose.yml --profile dev up -d
```

This will insert the data from `seeding.json` into mongoDB at startup. All services will start, and the seeder will automatically shut down after completing the seeding.

This is the reference link for the profiles with compose: https://docs.docker.com/compose/how-tos/profiles/



### Note

To prevent data stored in MongoDB from the development environment from persisting in the production environment, I deleted the local volumes storage.