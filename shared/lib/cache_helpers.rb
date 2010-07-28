module FikusCacheHelpers
  def cache_filename(path_name)
    path_name = (path_name.nil? || path_name.empty?) ? 'index' : path_name
    cache_path = File.join(Padrino.root, "app", "cache")
    FileUtils.mkdir_p(cache_path) if !File.directory?(cache_path)    
    cache_file = File.join(cache_path, "#{path_name}.html")  
  end  

  def sweep_cache(path_name, options={})
    if (options[:all])
      FileUtils.rm_rf(File.join(Padrino.root, "app", "cache", "*"))
    else
      FileUtils.rm(cache_filename(path_name))
    end
  end

  def sweep_all_cache()
    sweep_cache(nil, :all => true)
  end

  def cache_page(page)
    cache_file = cache_filename(page.path)
    if !File.exist?(cache_file)
      output = render('shared/page', :layout => get_valid_layout(page.layout))
      File.open(cache_file, 'w') { |f| f.write(output) } if FikusConfig.cache_strategy == 'filesystem'
    end
    output
  end

  def get_cache(path_name)
    cache_file = cache_filename(path_name)
    max_age = FikusConfig.max_cache_time
    now = Time.now
    if File.file?(cache_file)
      (current_age = (now - File.mtime(cache_file)).to_i / 60)
      return false if (current_age > max_age)
      return File.read(cache_file)
    end
    false
  end
end