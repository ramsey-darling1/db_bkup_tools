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
    puts "Hello, welcome to db bkup tools"
    puts "Enter help for help"
    input = get_user_input()
    manage_input(input)
end

def manage_input(i)
    case i
    when "help"
        puts "You asked for help!"
        puts "Available commands are:"
        puts "replace local - replace local database with empty copy of same name"
    when "replace local"
        puts "Will replace local database with empty database of same name"
        puts "Enter name of database to replace, cancel to abort:"
        db_name = gets.strip
        if db_name == 'cancel'
            puts "Aborting..."
            input = get_user_input()
            manage_input(input)
        else
            puts "Please enter database user:"
            user = gets.strip
            puts "Please enter password for database user:"
            pass = gets.strip
            replace_db_instance('localhost',user,pass,name)
            puts "Database dropped, new database with same name created"
            next_phase()
        end
    when "exit"
        puts "Bye!"
        exit!
    else
        #recurse until we get something useful
        puts "Sorry, request not understood"
        input = get_user_input()
        manage_input(input)
    end
end

def next_phase
    input = get_user_input()
    manage_input(input)
end

def get_user_input
    puts "Please enter your command: "
    return gets.strip
end

def generate_gateway
    gateway = Net::SSH::Gateway.new(@ssh_host,@ssh_user)
    gateway.open('127.0.0.1', 27017, 27018)
    return gateway
end

def shutdown_gateway(gateway)
    gateway.shutdown!
end

def generate_dump(user,name,file_name)
    exec "mysqldump -p -u #{user} -h localhost #{name} > #{file_name}"
end

def download_db_dump(path_to_file)
    exec "scp #{@ssh_user}@#{@ssh_host}:#{path_to_file} ."
end

def import_db(import_file)
    exec "mysql -p -u #{@db_user} -h localhost #{@db_name} < #{import_file}"
end

def replace_db_instance(host,user,pass,name)
    client = Mysql2::Client.new(:host => host, :username => user, :password => pass)
    client.query("DROP DATABASE IF EXISTS #{name}")
    client.query("CREATE DATABASE #{name}")
    client.close
end

#run the program
db_bkup_tools_main()
