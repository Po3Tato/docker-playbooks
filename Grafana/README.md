Grafana is an open-source data visualization and monitoring tool that lets you create interactive dashboards to explore, analyze, and monitor your data. It connects to various data sources and provides charts, graphs, and alerts.

## Folder Structure
```
./Grafana
├── grafana-data/
│   ├── prometheus/
│   │   └─config/
│   │     └─prometheus.yml
│   └── snmp-exporter-config/
│       └─snmp-target.yml
└── docker-compose.yml
```

## File and Folder configuration
- Edit `prometheus.yml` accordingly.
- Create docker network `grafana-net`.
