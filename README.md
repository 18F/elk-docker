# Elasticsearch, Logstash, Kibana (ELK) Docker image

This Docker image provides a convenient centralised log server and log management web interface, by packaging Elasticsearch (version 1.7.1), Logstash (version 1.5.4), and Kibana (version 4.1.1), collectively known as ELK.

### Documentation

See the [ELK Docker image documentation web page](https://spujadas.github.io/elk-docker) for complete instructions on how to use this image.

### About

Written by [Sébastien Pujadas](https://pujadas.net), released under the [Apache 2 license](https://www.apache.org/licenses/LICENSE-2.0).

### About This Fork

The 18F fork makes several changes in the interest of making the image easy to use as a self-service offering for a [Cloud Foundry](https://www.cloudfoundry.org/) environment via the [cf-containers-broker](https://github.com/cf-platform-eng/cf-containers-broker) and [docker-boshrelease](https://github.com/cf-platform-eng/docker-boshrelease). For broker + swarm templates see [18F/cloud-foundry-manifests](https://github.com/18F/cloud-foundry-manifests/tree/docker-boshrelease-manifest/docker-boshrelease/docker-swarm).

- Adds Elasticsearch plugins:
	* [aws-cloud](https://github.com/elastic/elasticsearch-cloud-aws)
	* [http-basic](https://github.com/Asquera/elasticsearch-http-basic)
	* [mapper-attachments](https://github.com/elastic/elasticsearch-mapper-attachments)
	* [marvel](https://www.elastic.co/guide/en/marvel/current/index.html)
- Inserts broker-provided credentials to support basic authentication for Elasticsearch.
- Uses an alternate installation method for Elasticsearch to support straightforward sharing of configuration with [18F/docker-elasticsearch](https://github.com/18F/docker-elasticsearch).

