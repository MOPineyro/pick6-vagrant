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

cookbook 'rbenv', git: 'https://github.com/fnichol/chef-rbenv'

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

script "install_rbenv" do
  code <<-EOH
    git clone git://github.com/sstephenson/rbenv.git .rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> .bash_profile
    echo 'eval "$(rbenv init -)"' >> .bash_profile
    source ~/.bash_profile
    git clone git://github.com/sstephenson/ruby-build.git
    cd ruby-build
    sudo ./install.sh
    ruby-build --definitions
  EOH
end

#
# Install Ruby 2.1
#
script "install_ruby" do
	code <<-EOH
		rbenv install 2.1.3
		rbenv rehash
	EOH
end

# package 'ruby2.1'
# package 'ruby2.1-dev'

#
# Install Bundler, build it against the newly installed 2.1 gem binary
#
gem_package 'bundler' do
  gem_binary('/usr/bin/gem2.1')
end

#
# Install yajl-ruby, required for re-provisioning Chef.
#
gem_package 'yajl-ruby' do
  gem_binary('/usr/bin/gem2.1')
end

#
# Install Rails.
#
gem_package 'rails' do
  gem_binary('/usr/bin/gem2.1')
end
