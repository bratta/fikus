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

That will prompt you to enter an email/password for your admin user.
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
