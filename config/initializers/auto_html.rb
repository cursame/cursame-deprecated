require 'net/http'
require 'json'

AutoHtml.add_filter(:image_with_link).with({}) do |text, options|
  text.gsub(/https?:\/\/.+\.(jpg|jpeg|bmp|gif|png)(\?\S+)?/i) do |match|
    img = ActionView::Base.new.image_tag(match)
    "<a href=\"#{ERB::Util.html_escape match}\" target=\"_blank\">#{img}</a>"
  end
end


AutoHtml.add_filter(:dailymotion_with_wmode).with(:width => 480, :height => 360) do |text, options|
  text.gsub(/https?:\/\/(www\.|)dailymotion\.com.*\/video\/(.+)_*/) do
    video_id = $2
    %{<object type="application/x-shockwave-flash" data="http://www.dailymotion.com/swf/#{video_id}&related=0" width="#{options[:width]}" height="#{options[:height]}"><param name="wmode" value="transparent"></param><param name="movie" value="http://www.dailymotion.com/swf/#{video_id}&related=0"></param><param name="allowFullScreen" value="true"></param><param name="allowScriptAccess" value="always"></param><a href="http://www.dailymotion.com/video/#{video_id}?embed=1"><img src="http://www.dailymotion.com/thumbnail/video/#{video_id}" width="#{options[:width]}" height="#{options[:height]}"/></a></object>}
  end
end

AutoHtml.add_filter(:ustream_support).with(:width => 400) do |text, options|
  text.gsub(/https?:\/\/(www\.|)ustream\.tv\/channel\/(.+)/) do
    channel = $2
    url = URI.parse("http://api.ustream.tv/json/channel/#{channel}/getCustomEmbedTag?key=31FDCB7300AAE3F5AD7E4302B4FE1E0C&params=autoplay:false;mute:false;width:#{options[:width]}")
    req = Net::HTTP::Get.new(url.request_uri)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    case res
      when Net::HTTPSuccess, Net::HTTPRedirection
        html = JSON.parse(res.body)["results"]
      else
        html = text
    end
    %{#{html}}
  end
end
  
AutoHtml.add_filter(:slideshare_support).with(:width => 400) do |text, options|
  text.gsub(/https?:\/\/(www\.|)slideshare\.net\/(.+)\/(.+)/) do
    url = URI.parse("http://www.slideshare.net/api/oembed/2?url=#{text}&format=json&maxwidth=#{options[:width]}")
    req = Net::HTTP::Get.new(url.request_uri)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    case res
      when Net::HTTPSuccess, Net::HTTPRedirection
        html = JSON.parse(res.body)["html"]
      else
        html = text
    end
    %{#{html}}
  end
end

AutoHtml.add_filter(:prezi_with_wmode).with(:width => 400, :height => 360) do |text, options|
  text.gsub(/https?:\/\/(www\.|)prezi\.com\/(.+)\/(.+)/) do
    user = $2
    %{<object id="prezi_#{user}" name="prezi_#{user}" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="#{options[:width]}" height="#{options[:height]}"><param name="wmode" value="transparent"></param><param name="movie" value="http://prezi.com/bin/preziloader.swf"/><param name="allowfullscreen" value="true"/><param name="allowscriptaccess" value="always"/><param name="bgcolor" value="#ffffff"/><param name="flashvars" value="prezi_id=#{user}&amp;lock_to_path=1&amp;color=ffffff&amp;autoplay=no&amp;autohide_ctrls=0"/><embed id="preziEmbed_#{user}" name="preziEmbed_#{user}" src="http://prezi.com/bin/preziloader.swf" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="400" height="400" bgcolor="#ffffff" flashvars="prezi_id=#{user}&amp;lock_to_path=1&amp;color=ffffff&amp;autoplay=no&amp;autohide_ctrls=0"></embed></object>}
  end
end

AutoHtml.add_filter(:livestrem_support).with(:width => 400, :height => 360) do |text, options|
  text.gsub(/https?:\/\/(www\.|)livestream\.com\/(.+)/) do
    user = $2
    %{<object width="#{options[:width]}" height="#{options[:height]}" id="lsplayer" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"><param name="movie" value="http://cdn.livestream.com/grid/LSPlayer.swf?channel=#{user}&amp;autoPlay=false"></param><param name="allowScriptAccess" value="always"></param><param name="allowFullScreen" value="true"></param><embed name="lsplayer" wmode="transparent" src="http://cdn.livestream.com/grid/LSPlayer.swf?channel=#{user}&amp;autoPlay=false" width="#{options[:width]}" height="#{options[:height]}" allowScriptAccess="always" allowFullScreen="true" type="application/x-shockwave-flash"></embed></object><div style="font-size: 11px;padding-top:10px;text-align:center;width:560px">Watch <a href="http://www.livestream.com/?utm_source=lsplayer&amp;utm_medium=embed&amp;utm_campaign=footerlinks" title="live streaming video">live streaming video</a> from <a href="http://www.livestream.com/#{user}?utm_source=lsplayer&amp;utm_medium=embed&amp;utm_campaign=footerlinks" title="Watch #{user} at livestream.com">#{user}</a> at livestream.com</div>}
  end
end

