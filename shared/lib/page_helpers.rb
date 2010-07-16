module FikusPageHelpers
  def all_layouts
    Dir.entries(File.join(Padrino.root, "app", "views", "layouts")).select {|x| x =~ /\.haml$/}
  end
  
  def get_valid_layout(layout_to_use)
    full_layout_path = File.join(Padrino.root, "app", "views", "layouts", layout_to_use)
    (File.exist?("#{full_layout_path}")) ? "layouts/#{layout_to_use.gsub(/\.haml$/,'')}".to_sym : :'layouts/application'
  end
  
  def render_page(path_name)
    current_cache = get_cache(path_name)
    if !current_cache
      @page = Page.find_by_path(path_name)
      halt 404 if !@page
      return cache_page(@page)
    end
    current_cache
  end
  
  def markdown(text)
    markdown = RDiscount.new(text, :smart)
    markdown.to_html
  end  
end