# Deploy hook helper methods for shared config files on the Engine Yard AppCloud
# NOTE: You need to have these customized files put in place with Chef
# Along with any other customized files you need.
['config.rb', 'fikus.yml'].each do |cfg_file|
  if File.exist?(cfg_file)
    run "ln -nsf #{shared_path}/config/#{cfg_file} #{release_path}/config/#{cfg_file}"
  end
end
