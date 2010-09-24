module FikusCacher

  # By default, don't perform any caching.
  class FikusCacher
    def cache(page)
      return true
    end
  
    def sweep(options={})
      return true
    end
  
    # Return false if no caching was performed, else return cached contents
    def retrieve(page)
      yield
    end
  
    def get_valid_layout(layout_to_use)
      full_layout_path = File.join(Padrino.root, "app", "views", "layouts", layout_to_use)
      (File.exist?("#{full_layout_path}")) ? "layouts/#{layout_to_use.gsub(/\.haml$/,'')}".to_sym : :'layouts/application'
    end  
  end


  class FileSystemCacher < FikusCacher
    def cache(page)
      cache_file = cache_filename(page.id.to_s)
      if !File.exist?(cache_file)
        output = yield
        File.open(cache_file, 'w') { |f| f.write(output) }
      end
      output
    end
  
    def sweep(options)
      if (!options[:page])
        FileUtils.rm_rf(File.join(Padrino.root, "app", "cache", "*"))
      else
        FileUtils.rm(cache_filename(options[:page].id.to_s))
      end
    end
  
    def retrieve(page)
      cache_file = cache_filename(page.id.to_s)
      max_age = FikusConfig.max_cache_time
      now = Time.now
      if File.file?(cache_file)
        (current_age = (now - File.mtime(cache_file)).to_i / 60)
        return File.read(cache_file) if (current_age <= max_age)
      else
       self.cache(page) { yield }
     end
    end
  
    def cache_filename(page_id)
      cache_path = File.join(Padrino.root, "app", "cache")
      FileUtils.mkdir_p(cache_path) if !File.directory?(cache_path)
      cache_file = File.join(cache_path, "#{page_id}.html")  
    end  
  end


  class VarnishCacher < FikusCacher
    def retrieve(page)
      response.headers['Cache-Control'] = "public, max-age=#{FikusConfig.max_cache_time}"
      yield
    end
  end
end