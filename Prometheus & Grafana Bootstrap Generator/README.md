# Prometheus & Grafana Bootstrap Generator

Write a single Bash script called `execute.sh` that generates a complete, production-ready observability configuration by creating the following files in the `out/` directory.

## Required Output Files

### 1. out/prometheus.yml

A valid Prometheus configuration with:

* `global` section
* At least 2 `scrape_configs` (e.g., prometheus itself + node exporter or app)
* Proper `job_name` and `static_configs`

### 2. out/datasource.yml

Grafana provisioning file for datasources:

```yaml
apiVersion: 1
datasources:
  - name: Prometheus
    type: prometheus
    url: http://localhost:9090
    isDefault: true
    access: proxy
```

### 3. out/dashboard.json

A valid Grafana dashboard JSON with:

* At least one panel
* Proper structure: `{ "dashboard": { "title": ..., "panels": [...] } }`
* Valid JSON formatting

### 4. out/alerts.yml

Prometheus Alerting rules file:

```yaml
groups:
  - name: example
    rules:
      - alert: InstanceDown
        expr: up == 0
        for: 5m
        annotations:
          summary: "Instance {{ $labels.instance }} is down"
```

## Requirements

* All generated YAML files must be syntactically valid
* All JSON files must be valid and parseable
* Files must follow industry-standard formats for Prometheus and Grafana
* The script must create the `out/` directory if it doesn't exist
* All files must be generated and written in a single script execution