module ActiveRecord
  module HTMLSanitization

    def html_sanitized attr
      define_method "#{attr}=" do |html|
        html       = Sanitize.clean(html, Sanitize::Config::BASIC)
        self[attr] = AutoHtml.auto_html html do
          youtube      :width => 400, :height => 250
          vimeo        :width => 400, :height => 250
          google_video :width => 400, :height => 250
          dailymotion  :width => 400, :height => 250
          image
          link :target => "_blank", :rel => "nofollow"
          simple_format
        end
      end

      define_method attr do
        ActiveSupport::SafeBuffer.new self[attr] if self[attr]
      end
    end
  end
end
