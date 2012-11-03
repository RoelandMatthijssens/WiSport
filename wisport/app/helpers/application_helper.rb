module ApplicationHelper
  
  # optional hash parameters are:
  # => :id => gives an id to the surrounding div
  # => :span => sets the span of the form (max=12, it uses twitter bootstrap for layout)
  # => :class => gives extra clases to the surrounding div
  # => :title => sets a h4 title in the form
  def floating_form partial, hash_arguments = {}
    id = hash_arguments[:id] || partial
    span = hash_arguments[:span] || 8
    offset = (12 - span) / 2
    classes = hash_arguments[:class] || ""
    title = hash_arguments[:title]
    form_type = floating_form_flash_type
    
    classes+= " floating_form_success" if form_type == :notice
    classes+= " floating_form_failure" if form_type == :error
    
    content_tag :div, 
      (content_tag :div,
        (title ? (content_tag :h4, title)+floating_form_flash+render(partial) : floating_form_flash+render(partial)), 
        class:"floating_form span#{span} offset#{offset} pagination-centered #{classes}"), 
      class:"row",
      id: id
  end
  
  def floating_form_no_flash partial, hash_arguments = {}
    id = hash_arguments[:id] || partial
    span = hash_arguments[:span] || 8
    offset = (12 - span) / 2
    classes = hash_arguments[:class] || ""
    title = hash_arguments[:title]
    content_tag :div, 
      (content_tag :div,
        (title ? (content_tag :h4, title)+render(partial) : render(partial)), 
        class:"floating_form span#{span} offset#{offset} pagination-centered #{classes}"), 
      class:"row",
      id: id
  end
  
  def floating_form_flash_type
    type = :none
    flash.each do |name, msg| 
		  name == :notice ? type = :success : type = :error
		end
		type
  end
    
  def floating_form_flash
    content = content_tag :div, ""
    flash.each do |name, msg| 
		  content+=content_tag(:h4, msg)
		end 
		content
  end
end
