define :website, :enable => true do
  include_recipe "nginx"

  template "#{node['nginx']['dir']}/sites-available/#{params[:name]}.conf" do
    source "nginx/website.erb"
    owner "root"
    group "root"
    mode 0644

    variables( :params => params )
  end

  nginx_site "#{params[:name]}.conf" do
    enable enable
  end
end
