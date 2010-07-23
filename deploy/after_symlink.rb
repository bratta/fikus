# Deploy hook helper methods for shared config files on the Engine Yard AppCloud
# NOTE: You need to have these customized files put in place with Chef
# Along with any other customized files you need.
['database.rb', 'fikus.yml'].each do |cfg_file|
  cfg_file_path = "#{shared_path}/config/#{cfg_file}"
  if File.exist?(cfg_file_path)
    run "ln -nsf #{cfg_file_path} #{release_path}/config/#{cfg_file}"
  end
end
