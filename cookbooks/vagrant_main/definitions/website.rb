define :website_stock, :enable => true, :http => true do
  include_recipe "nginx"

  template "#{node['nginx']['dir']}/sites-available/#{params[:name]}.conf" do
    source "nginx/website.erb"
    owner "root"
    group "root"
    mode 0644

    variables( :params => params )
  end

  directory "/var/www/#{params[:name]}" do
    owner node['nginx']['user']
    group node['nginx']['user']
    mode "0755"
    recursive true
    action :create
  end

  if params[:php]
    file "/var/www/#{params[:name]}/index.php" do
      action :create
      content "<h1>#{params[:name]} is configured</h1><?php phpinfo(); ?>"
    end
  else
    file "/var/www/#{params[:name]}/index.html" do
      action :create
      content "<h1>#{params[:name]} is configured</h1>"
    end
  end

  directory "/var/log/nginx/#{params[:name]}" do
    owner "root"
    group "root"
    mode "0755"
    recursive true
    action :create
  end

  if params[:enable] == true; nginx_site "#{params[:name]}.conf" do; enable true end; end
end
