# -*- encoding : utf-8 -*-
module Support::TableHelper
	#
  def sorted_table_header_tag(association, attribute, &block)
    content = capture { yield }.strip
		render(:partial => "support/sort", :locals => {:content => content, :association => association, :attribute => attribute})
  end

	#
  def filter_table_header_tag(association, attribute, options, &block)
    content = capture { yield }.strip
    render(:partial => "support/filter", :locals => {:content => content, :association => association, :attribute => attribute, :options => options})
  end

  def table_header_tag(title)
    content_tag(:th) do
      content_tag(:div, title, :class => "title")
    end
  end
end
