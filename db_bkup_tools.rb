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
    #step one
    #create tunnel
    gateway = Net::SSH::Gateway.new(@ssh_host,@ssh_user)
    
end

def dbbkupt_download_db_dump
    #step two
end

def dbbkupt_replace_local_db_instance
    #step three
    client = Mysql2::Client.new(:host => @db_host, :username => @db_user, :password => @db_pass)
    client.query("DROP DATABASE IF EXISTS #{@db_name}")
    client.query("CREATE DATABASE #{@db_name}")
    client.close
end
