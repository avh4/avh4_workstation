
ruby_block "Install gcc with osx-gcc-installer" do
  block do
    system("cd #{Chef::Config[:file_cache_path]}/ && curl -OL https://github.com/downloads/kennethreitz/osx-gcc-installer/GCC-10.7-v2.pkg")
    system("installer -package  #{Chef::Config[:file_cache_path]}/GCC-10.7-v2.pkg -target /")
  end
  not_if {File.exists?("/usr/bin/gcc-4.2")}
end

ruby_block "test gcc install with osx-gcc-install worked" do
  block do
    raise "osx-gcc-install install failed!" if ! File.exists?("/usr/bin/gcc-4.2")
  end
end

