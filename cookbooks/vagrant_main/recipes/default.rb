group "www" do
  action :create
end

user "www" do
  gid "www"
  home "/var/www"
  system true
  shell "/bin/false"
end

require_recipe "apt"

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

apt_repository "ajenti" do
  uri "http://repo.ajenti.org/debian"
  distribution "main"
  components ["main"]
  key "http://repo.ajenti.org/debian/key"
end

execute "apt-get update" do
  user "root"
end

require_recipe "build-essential"
require_recipe "php"
require_recipe "nginx"
require_recipe "mysql::server"
require_recipe "git"
require_recipe "imagemagick"
require_recipe "openssl"

cookbook_file "/root/ajenti-re.conf" do
  source "ajenti/ajenti-re.conf"
  mode 0640
  owner "root"
  group "root"
end

%w{ libpcre3-dev ajenti python-psutil python-imaging curl }.each do |package_name|
  package package_name
end

php_pear "apc"   do; action :install; end
php_pear "curl"  do; action :install; end
php_pear "gd"    do; action :install; end
php_pear "mysql" do; action :install; end

cookbook_file "/etc/nginx/fastcgi_params" do
  source "nginx/fastcgi_params"
  mode 0640
  owner "root"
  group "root"
end

node[:website].each do | name, website_config |
  website_stock name do
    server_name website_config[:server_name].nil? ? name : website_config[:server_name]
    enable  website_config[:enable]  if !website_config[:enable].nil?
    default website_config[:default] if !website_config[:default].nil?
    http    website_config[:http]    if !website_config[:http].nil?
    https   website_config[:https]   if !website_config[:https].nil?
    php     website_config[:php]     if !website_config[:php].nil?
  end
end