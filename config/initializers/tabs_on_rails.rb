class MenuTabBuilder < TabsOnRails::Tabs::Builder
  
  def tab_for(tab, name, options, item_options = {})
    item_options[:class] = item_options[:class].to_s.split(" ").push("active").join(" ") if current_tab?(tab)
    @context.content_tag(:li) do
      @context.link_to(name, options, item_options)
    end
  end
  
  def open_tabs(options = {})
    @context.tag("ul", options, open = true)
  end

  def close_tabs(options = {})
    "</ul>".html_safe
  end
  
end

class TabsBuilder < TabsOnRails::Tabs::Builder
  
   def tab_for(tab, name, options, item_options = {})
     item_options[:class] = item_options[:class].to_s.split(" ").push("active").join(" ") if current_tab?(tab)
     content = @context.link_to_unless(current_tab?(tab), name, options) do
       @context.content_tag(:span, name)
     end
     @context.content_tag(:li, content, item_options)
   end
  
  def open_tabs(options = {})
    @context.tag("ul", options, open = true)
  end

  def close_tabs(options = {})
    "</ul>".html_safe
  end
  
end
