# Fikus - The Simple Ruby CMS

This is Fikus, a simple content management system written in the Ruby
programming language.

> "Fikus dreamed a dream for me / 
> It cost me nothing it was free / 
> He dreamed of walking in the sand / 
> Of blossoms forming in his hand" / 
> -- from Fikus, by Phish

## About

### Features

* Simple admin interface
* Markdown format for page contents
* Easily extensible using the features of Padrino, Sinatra, and Rack
* Data stored in MongoDB
* Built-in page caching for performance
* Ability to specify different layouts per page

### Why Fikus?

I was in need of a very simple content management system. I wanted to quickly
author somewhat static pages together for the web, but I didn't want to deal
with deploying the site, uploading files, or dealing with fitting my content
in templates. That ruled out a lot of existing content management systems 
that did too much for what I wanted.

I also wanted a chance to play with the [Padrino](http://padrinorb.com) 
framework, which is a MVC architecture framework built on top of 
[Sinatra](http://sinatrarb.com). 

Initially I looked at a CMS like [Nesta](http://effectif.com/nesta) but
decided I wanted my pages (or documents) stored in a document database 
and a simple admin interface for editing them. I liked the idea of using
Markdown, so I decided to create something that fit my needs.

Fikus was born.

### What does Fikus mean?

Think of it as a tree, but I was listening to Phish when starting the 
project. That's all it is.

## Installation

The easiest way to get started is to fork the main repository on 
[Github](http://github.com):

    http://github.com/bratta/fikus
    
Now you can clone it and make your own edits easily, and even send
pull requests for any neato features you've added or bugs you've 
squashed.

### Pre-requisites

You're going to need ruby 1.8.7 (ish--may work on 1.8.6, but not tested),
RubyGems >= 1.3.6, and a few gems installed first:

    gem install bundler
    gem install padrino --version 0.9.14
    
You're also going to need access to a [MongoDB](http://mongodb.org)
database, and rack-compatible webserver when you're ready to 
deploy this puppy.

### Go Go Go!

Now that' you've got the pre-reqs and the code, let's bootstrap it:

* Edit the config/database.rb to match your MongoDB setup
* Edit the config/fikus.yml to match your site specifics

Let's get our gems installed and create a default user:

    cd fikus
    bundle install
    padrino rake seed

That will create a default admin user for you. Take the given info, login via 
the admin URL at /admin and make sure you change your account info!

Do it do it do it!

Next, boot it up:

    padrino start
    
And in your web browser, hit the URL: http://localhost:3000/admin

Now you can add some pages and be good to go!

### Customization

You can edit your site layouts in app/views/layouts. Add new templates
there and you will be able to choose it when creating/editing your
pages. The layout markup is [HAML](http://haml-lang.com/) so have
fun!

All static assets need to go in public/.

### PLEASE NOTE:

Your default home page will be whatever you specify WITHOUT a path. 
Anything else will show up at http://localhost:3000/page_path

## Deployment notes

### Engine Yard AppCloud

This application works on the Engine Yard AppCloud. The recommended method
of deployment is as follows:

Create your environment with Ruby 1.8.7 and use Unicorn (recommended) or
Passenger. Add the bundler gem and padrino to your application's required
gems. The "bundle install" will do the rest.

Fork Engine Yard's chef recipe repository here:

    http://github.com/engineyard/ey-cloud-recipes

Then copy the "chef/fikus" folder in this repository over to the
ey-cloud-recipes/cookbooks/fikus folder. You will want to edit the
fikus.yml file there to your liking. Then you will need to add the 
mongodb and fikus recipes to cookbooks/main/recipes/default.rb:

    require_recipe "mongodb"
    require_recipe "fikus"

Commit the changes and apply using the "ey" command. For more information,
please see the Chef documentation on the Engine Yard website:

    http://docs.engineyard.com/appcloud/howtos/customizations/custom-chef-recipes
    
The MongoDB recipe by default installs to a utility instance named 
mongodb_master. So if you want it on a single instance some hacking is
required. I heartily recommend against having MongoDB on the same instance
as your application and MySQL.

Boot your cluster, skip running migrations, and run "padrino rake seed" from
the application's directory.

### Heroku

This application will work with Heroku, provided your environment is set to 
use a cache_strategy of 'varnish' in your config/fikus.yml file.

Then it is a simple matter of doing this:

    heroku create --stack bamboo-ree-1.8.7
    heroku addons:add mongohq:free
    git push heroku master
    heroku rake seed
    
After that, you can login by going to http://myappname.heroku.com/admin
and entering the credentials set up for you.

## Get involved

Getting involved is a simple matter of forking the code and submitting 
a pull request. I'll accept any patches that make sense. If you want 
to become an active developer, get in touch with me on github and 
I'll get you access to commit directly.

### Issues

We're on Lighthouse. I'd prefer tickets going there:

    http://fikus.lighthouseapp.com/projects/59205-fikus/overview
    
