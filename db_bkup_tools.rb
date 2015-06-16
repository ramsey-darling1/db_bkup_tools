#automating some tasks that I have to often do
#creating and pulling down database dumps
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
    dbbkupt_generate_remote_db_dump()
end

def generate_remote_db_dump
    gateway = Net::SSH::Gateway.new(@ssh_host,@ssh_user)
end

def generate_dump(file_name)
    exec "mysqldump -p -u #{@db_user} -h localhost #{@db_name} > #{file_name}"
end

def download_db_dump(path_to_file)
    exec "scp #{@ssh_user}@#{@ssh_host}:#{path_to_file} ."
end

def import_db(import_file)
    exec "mysql -p -u #{@db_user} -h localhost #{@db_name} < #{import_file}"
end

def replace_db_instance
    client = Mysql2::Client.new(:host => @db_host, :username => @db_user, :password => @db_pass)
    client.query("DROP DATABASE IF EXISTS #{@db_name}")
    client.query("CREATE DATABASE #{@db_name}")
    client.close
end
