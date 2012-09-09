apt_repository "nginx" do
  uri "http://ppa.launchpad.net/nginx/stable/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "C300EE8C"
end

apt_repository "php5" do
  uri "http://ppa.launchpad.net/ondrej/php5/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "E5267A6C"
end

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

group "www" do
  action :create
end

user "www" do
  gid "www"
  home "/var/www"
  system true
  shell "/bin/false"
end

cookbook_file "/etc/nginx/sites-available/default" do
  source "nginx/sites/default"
  mode 0640
  owner "root"
  group "root"
  notifies :restart, resources(:service => "nginx")
end

directory "/var/log/nginx/default" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

nginx_site 'default' do
  enable true
end

directory "/var/www/default" do
  owner "www"
  group "www"
  mode "0755"
  recursive true
  action :create
end

file "/var/www/default/index.html" do
  action :create
  content "<h1>Server is configured</h1>"
end