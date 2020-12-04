# docker_v2

### step 1 create laravel project

`docker-compose run --rm composer create-project --prefer-dist laravel/laravel .`

### step 2 start the container

`docker-compose up -d nginx`

### optional for queue and scheduler

`docker-compose up -d queue scheduler`
