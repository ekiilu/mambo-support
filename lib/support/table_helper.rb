# -*- encoding : utf-8 -*-
module Support::TableHelper
	#
  def sorted_table_header_tag(key, &block)
    content = capture { yield }.strip
    content_tag(:th) do
      content_tag(:div, content, :class => 'title') +
			content_tag(:div, :class => "sort") do
				link_to("+", params.merge(:page => 1, :sort_key => key, :sort_order => :asc), :class => "ascending #{active_class(@sort_key == key && @sort_order == :asc)}") +
				link_to("-", params.merge(:page => 1, :sort_key => key, :sort_order => :desc), :class => "descending #{active_class(@sort_key == key && @sort_order == :desc)}")
			end
    end
  end

	#
  def filter_table_header_tag(key, options, &block)
    content = capture { yield }.strip
    active = @filter_key && @filter_value && key == @filter_key

    options.unshift(["- All -", ""])

    content_tag(:th) do
      content_tag(:div, content, :class => 'title') +
      content_tag(:div, :class => "filter #{(active ? 'active' : nil)}") do
        form_tag("", :method => :get) do
          hidden_field_tag(:page, 1) +
          hidden_field_tag(:filter_key, key) +
          select_tag(:filter_value, options_for_select(options, @filter_value), :onchange => submit_form)
        end
      end
    end
  end

  def table_header_tag(title)
    content_tag(:th) do
      content_tag(:div, title, :class => 'title')
    end
  end
end
