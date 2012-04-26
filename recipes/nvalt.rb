unless File.exists?(node["nvalt_app_path"])

  remote_file "#{Chef::Config[:file_cache_path]}/nvalt.zip" do
    source node["nvalt_download_uri"]
    owner WS_USER
  end

  execute "unzip github_for_mac" do
    command "unzip #{Chef::Config[:file_cache_path]}/nvalt.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy nvalt to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/nvALT.app #{Regexp.escape(node["nvalt_app_path"])}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if nvALT.app was installed" do
    block do
      raise "nvALT.app was not installed" unless File.exists?(node["nvalt_app_path"])
    end
  end

end
