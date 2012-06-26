require_recipe "apt"
require_recipe "build-essential"
require_recipe "php"
require_recipe "nginx"
require_recipe "mysql::server"
require_recipe "git"
require_recipe "imagemagick"
require_recipe "openssl"

%w{ libpcre3-dev }.each do |package_name|
  package package_name
end

php_pear "apc"   do; action :install; end
php_pear "curl"  do; action :install; end
php_pear "gd"    do; action :install; end
php_pear "mysql" do; action :install; end