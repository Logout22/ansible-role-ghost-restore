#!/usr/bin/ruby2.7
require 'mustache'

SSH_BASE_PORT = 2220
DISTRIBUTIONS = [ "debian:buster", "debian:bullseye", "ubuntu:bionic", "ubuntu:focal" ]

testmachines = []
DISTRIBUTIONS.each_with_index do |distribution,index|
  counter = index + 1
  ssh_port = SSH_BASE_PORT + counter
  testmachines.push({
    distribution: distribution,
    index: counter,
    ssh_port: ssh_port,
    port_mapping: "\"#{ssh_port}:#{ssh_port}\""
  })
end

containers = Mustache.render(
  File.read("templates/container.mustache"),
  testmachines: testmachines
).rstrip!
links = Mustache.render(
  File.read("templates/link.mustache"),
  testmachines: testmachines
).rstrip!
docker_compose = Mustache.render(
  File.read("templates/docker_compose.mustache"),
  {containers: containers, links: links}
)
File.write("docker-compose.yml", docker_compose)

hosts = Mustache.render(
  File.read("templates/hosts.mustache"),
  testmachines: testmachines
)
File.write("hosts", hosts)
