class Page
  include MongoMapper::Document

  key :title,  String,  :required => true
  key :path,   String,  :unique => true
  key :body,   String,  :required => true
  key :layout, String,  :default => 'application.haml'
  key :weight, Integer, :numeric => true, :default => 0
  timestamps!
  
  def self.all_by_weight
    Page.all(:order => 'weight')
  end
  
end
