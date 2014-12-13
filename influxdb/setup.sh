# Run influxdb and create two new influxdb databases: "rbx" and "grafana"

/etc/init.d/influxdb start

until (curl -X POST 'http://localhost:8086/db?u=root&p=root' \
  -d '{"name": "rbx"}' 2>/dev/null) do sleep 1; done # Loop until success
echo 'Created database: "rbx"'

until (curl -X POST 'http://localhost:8086/db?u=root&p=root' \
  -d '{"name": "grafana"}' 2>/dev/null) do sleep 1; done # Loop until success
echo 'Created database: "grafana"'

