module FikusPageHelpers
  
  def current_site
    site = Site.get_site(request.host)
  end
  
  def all_layouts
    Dir.entries(File.join(Padrino.root, "app", "views", "layouts")).select {|x| x =~ /\.haml$/}
  end
  
  def get_valid_layout(layout_to_use)
    full_layout_path = File.join(Padrino.root, "app", "views", "layouts", layout_to_use)
    (File.exist?("#{full_layout_path}")) ? "layouts/#{layout_to_use.gsub(/\.haml$/,'')}".to_sym : :'layouts/application'
  end
  
  def markdown(text)
    markdown = RDiscount.new(text, :smart)
    markdown.to_html
  end
  
  def render_page(path_name)
      @page = Page.find_by_site_and_path(request.host, path_name)
      halt 404 if !@page
      FikusConfig.cacher.retrieve(@page) { render('shared/page', :layout => get_valid_layout(@page.layout)) }
  end  
end