# Monitoreo de docker

Este proyecto de docker compose implementa un stack de:
- [cAdvisor] / [node_exporter] como fuentes de datos
- [Prometheus] como almacenamiento / TSDB
- [Grafana] como frontend

Para arrancar el proyecto, correr el comando `docker compose up -d`

Por default el único puerto expuesto en el host es `3000` que corresponde a Grafana.
Para exponer los puertos de los otros componentes, ver los comentarios en [`docker-compose.yml`](docker-compose.yml)

Grafana tiene [un repositorio público de dashboards](https://grafana.com/grafana/dashboards/), incluyo en la carpeta [`grafana_dashboards`](grafana_dashboards/) algunos encontrados en ese repositorio que sirven para este caso de uso.

[cAdvisor]: https://github.com/google/cadvisor
[node_exporter]: https://github.com/prometheus/node_exporter
[Prometheus]: https://prometheus.io/
[Grafana]: https://grafana.com/