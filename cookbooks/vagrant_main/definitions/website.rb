define :website_stock, :enable => true do
  include_recipe "nginx"

  template "#{node['nginx']['dir']}/sites-available/#{params[:name]}.conf" do
    source "nginx/website.erb"
    owner "root"
    group "root"
    mode 0644

    variables( :params => params )
  end

  directory "/var/www/#{params[:server_name]}" do
    owner "www"
    group "www"
    mode "0755"
    recursive true
    action :create
  end

  file "/var/www/#{params[:server_name]}/index.html" do
    action :create
    content "<h1>#{params[:server_name]} is configured</h1>"
  end

  directory "/var/log/nginx/#{params[:server_name]}" do
    owner "root"
    group "root"
    mode "0755"
    recursive true
    action :create
  end

  nginx_site "#{params[:name]}.conf" do
    enable enable
  end
end
