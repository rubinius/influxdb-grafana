influxdb-grafana
================

Docker container for using InfluxDB + Grafana to consume Rubinius Metrics StatsD output

## Usage

```shell
docker run -d \
  -p 8125:8125/udp \
  -p 80:80 \
  rubinius/influxdb-grafana
```

(Depending on your docker installation, you may need to run with `sudo`)