# NGINX Load Balancer Config Generatorh

You are given 3 running backend servers on ports:

* 8081
* 8082
* 8083

Each is an `nginx:alpine` container serving on port 80 internally.

## Your Task

Write a single Bash script called `execute.sh` that:

* Generates a valid, syntax-correct NGINX configuration file at `./out/nginx.conf`
* Configures:
  * An upstream block with all 3 backend servers (`localhost:8081`, `8082`, `8083`)
  * A server block listening on port 80
  * `proxy_pass` to the upstream
  * Load balancing (round-robin by default is fine)
  * Health checks using at least one of:
    * `max_fails=3 fail_timeout=30s`
    * `health_check` directive (NGINX Plus style allowed in test)

## Requirements

The generated config must:

* Pass `nginx -t` (syntax check)
* Contain `upstream`, `server`, `proxy_pass`, and health-related directives
* Be a complete, working reverse proxy + load balancer config

## Example Expected Output (out/nginx.conf)

```nginx
upstream backend {
    server localhost:8081 max_fails=3 fail_timeout=30s;
    server localhost:8082 max_fails=3 fail_timeout=30s;
    server localhost:8083 max_fails=3 fail_timeout=30s;
}

server {
    listen 80;
    location / {
        proxy_pass http://backend;
    }
}
```