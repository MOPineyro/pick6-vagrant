#
# Cookbook Name:: cocoon
# Recipe:: _postgres
#
# Copyright (C) 2014 FullStack
#

#
# Install Postgres.
#
package 'postgresql'
package 'postgresql-contrib'

sudo sed -i "s/%admin ALL=\(ALL\)\ ALL/%admin ALL=\(ALL\) NOPASSWD:ALL/" /etc/sudoers

#
# Create a Postgres user.
#
execute 'createuser' do
  guard = <<-EOH
    psql -U postgres -c "select * from pg_user where
    usename='vagrant'" |
    grep -c vagrant
  EOH

  user 'postgres'
  command 'createuser vagrant'
  not_if guard, user: 'postgres'
end
