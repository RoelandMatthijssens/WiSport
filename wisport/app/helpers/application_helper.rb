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
      set_floating_form_content(title, partial, span, offset, classes), 
      class:"row",
      id: id
  end
  
  def set_floating_form_content title, partial, span, offset, classes, skip_flash=false
    content = content_tag(:a, "X",class: "floating_form_close", href: "#")
    content += content_tag(:h4, title) if title
    content += floating_form_flash unless skip_flash
    content += render(partial)
    
    content_tag :div,
      content, 
      class:"floating_form span#{span} offset#{offset} pagination-centered #{classes}"
  end
  
  def floating_form_no_flash partial, hash_arguments = {}
    id = hash_arguments[:id] || partial
    span = hash_arguments[:span] || 8
    offset = (12 - span) / 2
    classes = hash_arguments[:class] || ""
    title = hash_arguments[:title]
    content_tag :div,
      set_floating_form_content(title, partial, span, offset, classes, true), 
      class:"row",
      id: id
  end
  
  def floating_form_flash_type
    type = :none
    flash.each do |name, msg| 
		  name == :notice ? type = :success : type = :error
		end
		@form_type || type
  end
    
  def floating_form_flash
    content = ActiveSupport::SafeBuffer.new
    flash.each do |name, msg| 
		  content+=content_tag(:h4, msg)
		end
		content
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

end
