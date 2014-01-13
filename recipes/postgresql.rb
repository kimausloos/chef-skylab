include_recipe "applications::postgresql"

postgresuser = value_for_platform(
    ["ubuntu"] => { "default" => "postgres"},
    "default" => node['current_user']
)

dblocation = value_for_platform(
    ["ubuntu"] => { "default" => "/var/lib/postgresql"},
    "default" => "/usr/local/var/postgres"
)

execute "create the postgresql Skylab superuser" do
   command "psql -d template1 -c 'create user skylab;' && touch #{dblocation}/.create-postgresql-skylab-user-success"
    user postgresuser
    not_if do ::File.exists?("#{dblocation}/.create-postgresql-skylab-user-success") end
end

execute "create the postgresql Skylab superuser password" do
    command "psql  -d template1 -c \"alter user skylab with password '#{node['skylab']['postgresql']['password']}';\" && touch #{dblocation}/.set-postgresql-skylab-password-success"
    user postgresuser
    not_if do ::File.exists?("#{dblocation}/.set-postgresql-skylab-password-success") end
end

execute "grant the postgresql Skylab superuser" do
    command "psql  -d template1 -c 'GRANT SELECT ON pg_shadow TO skylab;' && touch #{dblocation}/.grant-postgresql-skylab-user-success"
    user postgresuser
    not_if do ::File.exists?("#{dblocation}/.grant-postgresql-skylab-user-success") end
end
