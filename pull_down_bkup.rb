require 'mysql2'
require 'net/ssh/gateway'

gateway = Net::SSH::Gateway.new(
    'remotehost.com',
    'username'
)
port = gateway.open('127.0.0.1', 3306, 3307)

client = Mysql2::Client.new(
    host: "127.0.0.1",
    username: 'dbuser',
    password: 'dbpass',
    database: 'dbname',
    port: port
)
results = client.query("SELECT * FROM projects")
results.each do |row|
    p row
end
client.close
