AutoHtml.add_filter(:image_with_link).with({:alt => ''}) do |text, options|
  alt = options[:alt]
  text.gsub(/https?:\/\/.+\.(jpg|jpeg|bmp|gif|png)(\?\S+)?/i) do |match|
    img = ActionView::Base.new.image_tag(match)
    "<a href=\"#{ERB::Util.html_escape match}\" target=\"_blank\">#{img}</a>"
  end
end


AutoHtml.add_filter(:dailymotion_with_wmode).with(:width => 480, :height => 360) do |text, options|
  text.gsub(/http:\/\/www\.dailymotion\.com.*\/video\/(.+)_*/) do
    video_id = $1
    %{<object type="application/x-shockwave-flash" data="http://www.dailymotion.com/swf/#{video_id}&related=0" width="#{options[:width]}" height="#{options[:height]}"><param name="wmode" value="transparent"></param><param name="movie" value="http://www.dailymotion.com/swf/#{video_id}&related=0"></param><param name="allowFullScreen" value="true"></param><param name="allowScriptAccess" value="always"></param><a href="http://www.dailymotion.com/video/#{video_id}?embed=1"><img src="http://www.dailymotion.com/thumbnail/video/#{video_id}" width="#{options[:width]}" height="#{options[:height]}"/></a></object>}
  end
end

