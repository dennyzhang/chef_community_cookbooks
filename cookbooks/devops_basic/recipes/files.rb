elasticsearch_configure 'elasticsearch' do
  allocated_memory node['my_elasticsearch']['allocated_memory']
  configuration (
    'cluster.name' => node['my_elasticsearch']['cluster_name'],
    'discovery.zen.ping.multicast.enabled' => \
    node['my_elasticsearch']['ping_timeout'],
    'network.host' => es_network_host
  )
end
