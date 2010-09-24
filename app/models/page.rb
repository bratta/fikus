class Page
  include MongoMapper::Document

  key :title,  String,  :required => true
  key :path,   String
  key :body,   String,  :required => true
  key :layout, String,  :default => 'application.haml'
  key :weight, Integer, :numeric => true, :default => 0

  timestamps!
  
  belongs_to :site
  
  validates_uniqueness_of :path, :scope => :site_id
  
  def self.all_by_weight(domain)
    Page.all(:site_id => Site.get_site(domain).id.to_s, :order => 'weight asc')
  end
  
  def self.find_by_site_and_path(domain, path)
    Page.first(:site_id => Site.get_site(domain).id.to_s, :path => path)
  end
  
end
