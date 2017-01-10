module Jekyll

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'index_tag.html')
      self.data['category'] = tag

      # tag_title_prefix = site.config['tag_title_prefix'] || 'Tag: '
      self.data['title'] = "#{tag}"
    end
  end

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'index_tag'
        dir = site.config['tags_dir'] || 'tag'
        site.tags.each_key do |tag|
          slug = tag.strip.downcase.gsub(' ', '-').gsub(/[^\w-]/, '')
          site.pages << TagPage.new(site, site.source, File.join(dir, slug), tag)
        end
      end
    end
  end

end