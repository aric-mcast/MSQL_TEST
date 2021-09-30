# Creating MYSQL Docker Container


# Docker Commands

## Running Docker Compose
```bash
docker-compose up -d
```

## Bashing into docker container

```bash
docker exec -it name bash
```

## Stopping Containers
```bash
docker-compose down
docker-compose down --rmi all
docker-compose down -v name
```

# Login Mysql

```bash
mysql -u root -pbazena##000!
```