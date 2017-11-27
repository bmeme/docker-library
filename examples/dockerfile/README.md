# Example with a Dockerfile

## Usage

- Copy your PHP application into: `php-code` directory

- `$ docker build -t my-php-dev-app .`

- `$ docker run -d --name my-running-app -p 8080:80 my-php-dev-app`

- Navigate to [localhost:8080](http://localhost:8080)

You are browsing your PHP application using Bmeme docker image.
