#
# Cookbook Name:: cocoon
# Recipe:: _ruby
#
# Copyright (C) 2014 FullStack
#

#
# Update dependencies.
#
execute 'apt-get update' do
  ignore_failure true
end

#
# Install Ruby Build Dependencies
#
package 'curl'
package 'wget'
package 'libssl-dev'
package 'libyaml-dev'
package 'libreadline-dev'
package 'libreadline6'
package 'libreadline6-dev'
package 'zlib1g'
package 'zlib1g-dev'
package 'libcurl4-openssl-dev'

package 'libxslt-dev'
package 'libxml2-dev'
package 'build-essential'
package 'libpq-dev'
package 'libsqlite3-dev'

#
# Add apt-add-repository.
#
package 'software-properties-common'

#
# Add brightbox ruby repo.
#
execute 'apt-add-repository ppa:brightbox/ruby-ng -y' do
  not_if 'which ruby | grep -c 2.1'
end

script "install_ruby" do
	interpreter "bash"
	code <<-EOH
		wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz
		tar -xzvf ruby-install-0.5.0.tar.gz
		cd ruby-install-0.5.0/
		sudo make install
		sudo ruby-install --system ruby 2.1.3
	EOH
end

#
# Install Ruby 2.1
#
# script "install_ruby" do
# 	interpreter "bash"
# 	code <<-EOH
		
# 	EOH
# end

# package 'ruby2.1'
# package 'ruby2.1-dev'

#
# Install Bundler, build it against the newly installed 2.1 gem binary
#
gem_package 'bundler' do
  action :install
end

#
# Install yajl-ruby, required for re-provisioning Chef.
#
# gem_package 'yajl-ruby' do
#   action :install
# end

#
# Install Rails.
#
gem_package 'rails' do
  action :install
end
