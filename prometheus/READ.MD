Prometheus/Grafana -  Obeservability -> logging, monitoring, alerting (time series metrics - measurement take over periods of time, at regular intervals 15 sec default)

*Grafana* is a visualization dashboard. 
*Loki* (logs aggregate) - collects logs from the source 
*Prometheus* -(data source) - you can check target hosts down and up. scrape_configs: (which retrieves)
  e.g.       job_name:"docker" -   it will come in Prometheus.yml as - targets:
                                                                       - cadvisor:8080

promtail - scrapes logs from different sources - nginx log, httpd logs -> dump data to prom tail and it can be visualized in -> grafana

Prometheus (time series db - organized by time. eg. financial market data, server logs.) -  
      docker logs ->  default 15secs retrieval pull-based mechanism  -> insert in DB -> prom-ql(HTTP server - call query server) to query db. 

Docker logs -  1) Prometheus  2) Cadvisor 3) Redis (DB, key-value pair) 
                                  cadvisor stores data to Redis.

Grafana template docker container and host metrics
prometh.yml (multiple endpoints in Prometheus)

e.g. 
- job_name: "node exporter"
node exporter - collects data from host system memory, cpu etc.  


![ Architecture Diagram](https://medium.com/@aichali42471/monitoring-distributed-systems-with-grafana-and-prometheus-f8cd3ca674cc)
