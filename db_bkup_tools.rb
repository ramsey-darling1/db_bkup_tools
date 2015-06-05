#automating some tasks that I have to often do
#@rdar

require 'mysql2'
require 'net/ssh/gateway'


@db_host = "localhost"
@db_user = "someuser"
@db_pass = "somepass"
@db_name = "test_db"
@ssh_user = "ssh_user"
@ssh_host = "ssh_host"
@ssh_pass = "ssh_password"


def db_bkup_tools_main
    #step one, ssh into remove server, do a db dump 
    dbbkupt_generate_remote_db_dump()
end

def dbbkupt_generate_remote_db_dump

    gateway = Net::SSH::Gateway.new(@ssh_host,@ssh_user)
    #port = gateway.open('127.0.0.1', 3306, 3307)
    client = Mysql2::Client.new(
        host: @db_host,
        username: @db_user,
        password: @db_pass,
        database: @db_name,
        port: port
    )
end
