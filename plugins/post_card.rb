require "./plugins/octopress_filters"
module Jekyll
  module Tags
    class PostCard < Liquid::Tag
      include OctopressLiquidFilters
      def initialize(tag_name, post, tokens)
        super
        v = post.strip.split[0]
        @post = post
        @opt = ''
        if v == 'url' || v == 'title_url' || v == 'image'
          m = post.strip.match(/(\w*) (.*)/)
          @opt = m[1]
          @post = m[2]
        end
        if @post.split[0].include?("/")
          @post = @post.split[0]
          if @post.split("/")[-1] == "index.html" ||
             @post.split("/")[-1] == "index.htm"
            @post = @post.split("/")[0..-2].join("/")
          end
          if ! @post.end_with?("html") && ! @post.end_with?("htm") &&
             @post[-1] != "/"
            @post += "/"
          end
        end
      end

      def render(context)
        site = context.registers[:site]
        if @post.split[0].include?("/")
          if @post.start_with?(site.config['url'])
            @post.gsub!(site.config['url'], "")
            if @post[0] != "/"
              @post = "/" + @post
            end
          end
          if @post.start_with?(site.config['root'])
            if site.config['root'] != "/"
              @post.gsub!(site.config['root'], "")
            end
            if @post[0] != "/"
              @post = "/" + @post
            end
          end
        end

        site.posts.docs.each do |p|
          if @post == p.data['title'] || @post == p.url ||
             @post.split('/')[-1].split('.')[0] ==
             p.path.split('/')[-1].split('.')[0]
            url = p.url
            return "<a href='#{url}'>#{url}</a>" if @opt == 'url'
            title = p.data['title']
            if title =~ /(.+)\/$|^\/$/
              title = $1
            end
            title.upcase! if site.config['titlecase']
            return "<a href='#{url}'>#{title}</a>" if @opt == 'title_url'
            img = ''
            amazon = false
            if !p['ogimage'].nil?
              img = p['ogimage']
            else
              begin
                img = amazon_img(p.content)
                if img != ''
                  img = '<div class="title-small-thumbnail">' + img + '</div>'
                  amazon = true
                end
              rescue
                img = ''
              end
            end
            img = site.config['sitelogo'] if img == '' &&
                                             site.config.key?('sitelogo')
            unless amazon
              thum = Jekyll::Thumbnail.parse('thumbnail', "small-thumbnail #{img}", '', '')
              img = '<div class="title-small-thumbnail">
  <a href="' + url + '">' + thum.render(context) + '</a>
</div>'
            end
            return img if @opt == 'image'
            desc = ''
            desc = '</br>' + p['description'] unless p['description'].nil?
            card = '<ul class="post_card"><li class="index_click_box"><div class="group">' + img + \
                   '<a class="click_box_link" href="' + url + '">' + \
                   title + '</a>' + desc + '</div></li></ul>'
            return card
          end
        end
        "<a href='#{@post}'>#{@post}</a>"
      end
    end
  end
end

Liquid::Template.register_tag('post_card', Jekyll::Tags::PostCard)
