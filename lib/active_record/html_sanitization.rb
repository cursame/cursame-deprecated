module ActiveRecord
  module HTMLSanitization
    extend self

    def sanitize html
      html = Sanitize.clean html, Sanitize::Config::BASIC
      AutoHtml.auto_html html do
        youtube      :width => "100%", :height => 250, :wmode => "transparent"
        vimeo        :width => "100%", :height => 250
        google_video :width => "100%", :height => 250
        metacafe     :width => "100%", :height => 250
        # This is defined in config/initializers/auto_html.rb
        dailymotion_with_wmode :width => "100%", :height => 250
        slideshare_support :width => "100%"
        ustream_support :width => "100%"
        prezi_with_wmode :width => "100%", :height => 360
        livestrem_support :width => "100%", :height => 360
        image_with_link
        link :target => "_blank", :rel => "nofollow"
        simple_format
      end
    end

    def html_sanitized attr
      define_method "#{attr}=" do |html|
        self[attr] = HTMLSanitization.sanitize html
      end

      define_method attr do
        ActiveSupport::SafeBuffer.new self[attr] if self[attr]
      end
    end
  end
end
