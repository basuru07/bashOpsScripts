#!/bin/bash
mkdir -p out

cat > out/nginx.conf << 'EOF'
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
EOF