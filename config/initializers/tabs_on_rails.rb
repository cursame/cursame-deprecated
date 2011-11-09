class MenuTabBuilder < TabsOnRails::Tabs::Builder
  
  # def tab_for(tab, name, options, item_options = {})
  #   item_options[:class] = (current_tab?(tab) ? 'active' : '')
  #   @context.content_tag(:li, item_options) do
  #     @context.link_to(name, options)
  #   end
  # end
  
  def tab_for(tab, name, options, item_options = {})
     item_options[:class] = item_options[:class].to_s.split(" ").push("active").join(" ") if current_tab?(tab)
     content = @context.link_to_unless(current_tab?(tab), name, options) do
       @context.link_to(name, options)
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