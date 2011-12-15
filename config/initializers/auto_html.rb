AutoHtml.add_filter(:image_with_link).with({:alt => ''}) do |text, options|
  alt = options[:alt]
  text.gsub(/https?:\/\/.+\.(jpg|jpeg|bmp|gif|png)(\?\S+)?/i) do |match|
    img = ActionView::Base.new.image_tag(match)
    "<a href=\"#{ERB::Util.html_escape match}\" target=\"_blank\">#{img}</a>"
  end
end
