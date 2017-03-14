['ruby','ruby-dev','gcc','sqlite3','libsqlite3-dev','zlib1g-dev','liblzma-dev','nodejs'].each do |chef|
  package chef do
    action :install
  end
end

execute 'gem update' do
  command 'gem update'
end

gem_package 'rails' do
  action :install
end

directory '/opt/computer-inventory' do
  owner 'vagrant'
  group 'vagrant'
  action :create
end

git '/opt/computer-inventory' do
  repository 'https://github.com/brandonlbarrow/computer-inventory.git'
  reference 'master'
  action :sync
end

execute 'bundle install' do
  cwd '/opt/computer-inventory'
end

execute 'change owner of app dir' do
  command 'chown -R vagrant:vagrant /opt/computer-inventory/'
end

execute 'rails server -b 0.0.0.0' do
  cwd '/opt/computer-inventory'
  user 'vagrant'
end
