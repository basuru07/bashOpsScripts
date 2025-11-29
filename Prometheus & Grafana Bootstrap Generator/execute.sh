#!/bin/bash
mkdir -p out

# prometheus.yml
cat > out/prometheus.yml << 'EOF'
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node'
    static_configs:
      - targets: ['host.docker.internal:9100', 'localhost:9100']
EOF

# datasource.yml for Grafana
cat > out/datasource.yml << 'EOF'
apiVersion: 1
datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://prometheus:9090
    isDefault: true
EOF

# dashboard.json
cat > out/dashboard.json << 'EOF'
{
  "dashboard": {
    "id": null,
    "title": "System Monitoring",
    "panels": [
      {
        "title": "CPU Usage",
        "type": "graph",
        "targets": [
          { "expr": "rate(node_cpu_seconds_total[5m])", "legendFormat": "{{cpu}}" }
        ]
      }
    ],
    "templating": { "list": [] },
    "refresh": "5s"
  }
}
EOF

# alerts.yml
cat > out/alerts.yml << 'EOF'
groups:
  - name: system-alerts
    rules:
      - alert: InstanceDown
        expr: up == 0
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "Instance {{ $labels.instance }} down"
          description: "{{ $labels.instance }} has been down for more than 5 minutes."
EOF