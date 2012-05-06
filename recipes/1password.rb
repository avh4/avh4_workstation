unless File.exists?(node["1password_app_path"])

  remote_file "#{Chef::Config[:file_cache_path]}/1Password.zip" do
    source node["1password_download_uri"]
    owner WS_USER
  end

  execute "unzip github_for_mac" do
    command "unzip #{Chef::Config[:file_cache_path]}/1Password.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy 1Password to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/1Password.app #{Regexp.escape(node["1password_app_path"])}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if 1Password.app was installed" do
    block do
      raise "1Password.app was not installed" unless File.exists?(node["1password_app_path"])
    end
  end

end
