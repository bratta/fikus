# This loads the site config file for your Fikus installation
# Customize fikus.yml to your tastes, and enjoy the power of a 
# stupid simple content management system powered by love!

config = YAML.load_file(File.join(Padrino.root, "config", "fikus.yml"))
::FikusConfig = OpenStruct.new(config[Padrino.env])