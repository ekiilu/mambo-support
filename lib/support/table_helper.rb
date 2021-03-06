#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
module Support::TableHelper
	#
  def sorted_table_header_tag(attribute, &block)
    content = capture { yield }.strip
		render(:partial => "support/sort", :locals => {:content => content, :attribute => attribute})
  end

	#
  def filter_table_header_tag(attribute, options, &block)
    content = capture { yield }.strip
    render(:partial => "support/filter", :locals => {:content => content, :attribute => attribute, :options => options})
  end

  def table_header_tag(title)
    content_tag(:th) do
      content_tag(:div, title, :class => "title")
    end
  end
end
