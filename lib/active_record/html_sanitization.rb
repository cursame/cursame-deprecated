module ActiveRecord
  module HTMLSanitization
    extend self

    def sanitize html
      html = Sanitize.clean html, Sanitize::Config::BASIC
      AutoHtml.auto_html html do
        youtube      :width => 400, :height => 250
        vimeo        :width => 400, :height => 250
        google_video :width => 400, :height => 250
        dailymotion  :width => 400, :height => 250
        image
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
