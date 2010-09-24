# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#
#email     = shell.ask "Which email do you want use for loggin into admin?"
#password  = shell.ask "Tell me the password to use:"

# Let's set up some sane defaults so we don't have to ask

email = "admin@domain.com"
password = "fikus"

site_name = 'Fikus'
site_domain = 'localhost'
site_tagline = 'The Simple Ruby CMS'

shell.say ""

site = Site.create(:name => site_name, :domain => site_domain, :tagline => site_tagline)
page = Page.create(:title => 'Fikus', :weight => 0, :path => '', :body => 'Hello, world!', :site_id => site.id.to_s)
account = Account.create(:email => email, :name => "Foo", :surname => "Bar", :password => password, :password_confirmation => password, :role => "admin")

if site.valid?
  shell.say "================================================================="
  shell.say "Initial site successfully created. Please edit before going live:"
  shell.say "================================================================="
  shell.say "   Name:    #{site_name}"
  shell.say "   Domain:  #{site_domain}"  
  shell.say "   Tagline: #{site_tagline}"
else
  shell.say "Sorry but some thing went worng!"
  shell.say ""
  site.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

if account.valid?
  shell.say "================================================================="
  shell.say "Account has been successfully created, now you can login with:"
  shell.say "================================================================="
  shell.say "   Email:    #{email}"
  shell.say "   password: #{password}"
  shell.say "================================================================="
else
  shell.say "Sorry but some thing went worng!"
  shell.say ""
  account.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say ""