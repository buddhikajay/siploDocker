Dockerized Siplo Environemet

Installation
------------

* Install Docker Engine
* Clone the project
* Get all the sub-modules
* Copy env.dist and create .env file
* Copy certs.dist file and create certs file. Setup SSL certificates in certs file.
* docker-compose build && docker-compose up -d

References
----------
* [maxpou/docker-symfony](https://github.com/maxpou/docker-symfony)
* [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy)