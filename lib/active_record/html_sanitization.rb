module ActiveRecord
  module HTMLSanitization
    def html_sanitized attr
      define_method "#{attr}=" do |html|
        self[attr] = Sanitize.clean(html, Sanitize::Config::BASIC)
      end

      define_method attr do
        ActiveSupport::SafeBuffer.new self[attr] if self[attr]
      end
    end
  end
end
