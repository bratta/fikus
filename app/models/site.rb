class Site
  include MongoMapper::Document

  key :name, String
  key :domain, String
  key :tagline, String
  timestamps!
  
  has_many :pages
  
  def self.get_site(domain)
    match = nil
    Site.all.each do |site|
      match = site if site.domain.match(domain)
    end
    match
  end
end
