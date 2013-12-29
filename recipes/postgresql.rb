include_recipe "applications::postgresql"

postgresuser = value_for_platform(
    ["ubuntu"] => { "default" => "postgres"},
    "default" => node['current_user']
)

execute "create the postgresql Skylab superuser" do
   command "psql -d template1 -c 'create user skylab;' && touch /var/lib/postgresql/.create-skylab-user-success"
    user postgresuser
    not_if do ::File.exists?('/var/lib/postgresql/.create-skylab-user-success') end
end

execute "create the postgresql Skylab superuser password" do
    command "psql  -d template1 -c \"alter user skylab with password '#{node['skylab']['postgresql']['password']}';\" && touch /var/lib/postgresql/.set-skylab-password-success"
    user postgresuser
    not_if do ::File.exists?('/var/lib/postgresql/.set-skylab-password-success') end
end

execute "grant the postgresql Skylab superuser" do
    command "psql  -d template1 -c 'GRANT SELECT ON pg_shadow TO skylab;' && touch /var/lib/postgresql/.grant-skylab-user-success"
    user postgresuser
    not_if do ::File.exists?('/var/lib/postgresql/.grant-skylab-user-success') end
end
