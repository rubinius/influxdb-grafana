influxdb-grafana
================

Docker container for using InfluxDB + Grafana to consume Rubinius Metrics StatsD output.

## Usage

1. **[Install docker](https://docs.docker.com/installation/)**.

2. **Run an instance of the container**.  If this is the first time you're running it, docker will automatically download the stack of images that make up the container from [the automated build of this repository](https://registry.hub.docker.com/u/rubinius/influxdb-grafana/).  The following command will run the container as a daemon (`-d`), mapping port `8125` of `localhost` to the container's `8125` statsd port, port `8086` of `localhost` to the container's `8086` influxdb query port, and port `80` of `localhost` to the container's `80` port serving the grafana interface.  Depending on how docker is installed, you may need to run this command with `sudo`.

    ```shell
    docker run -d \
      -p 8125:8125/udp \
      -p 8086:8086 \
      -p 80:80 \
      rubinius/influxdb-grafana
    ```

3. **Run your application** with Rubinius configured to output metrics to statsd at `localhost:8125`.

    ```shell
    RBXOPT="-Xsystem.metrics.target=statsd \
            -Xsystem.metrics.statsd.server=localhost:8125" \
      rbx # (your app here)
    ```

4. **Open the dashboard** in your browser at `http://localhost:80`.  The grafana dashboard will run in your browser, sending queries for data to influxdb at `http://localhost:8086`.

### Usage on Mac OS X

Because docker relies on features of the Linux kernel, it does not run containers natively in Mac OS X - it hosts containers inside of a Linux VM called `boot2docker`.  One consequence of this is that ports mapped to the docker host from containers are not mapped to `localhost` of OS X, but to the `boot2docker` host.  Therefore, in all of the above commands, OS X users should replace `localhost` with the IP address given by running `boot2docker ip`.

As mentioned in step 4 above, grafana runs in your browser, sending queries for data to influxdb at `http://localhost:8086`.  This also needs to be replaced with the `boot2docker ip` address by passing an environment variable into the docker container.  For example, if the `boot2docker ip` address in your setup is is `192.168.59.103`, the docker container could be run with the command:

```shell
docker run -d \
  -p 8125:8125/udp \
  -p 8086:8086 \
  -p 80:80 \
  -e INFLUXDB_SERVER=http://192.168.59.103:8086 \
  rubinius/influxdb-grafana
```
