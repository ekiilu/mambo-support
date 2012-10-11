#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
module Support::FormHelper
	#
	def options_for_enum(enum, val = nil)
		options_for_select(enum.options[:flags].map {|option| [I18n.t(".#{option}"), option]}, val)
	end

  def submit_form
    "javascript: this.form.submit();"
  end

  def active_class(bool)
    bool ? 'active' : 'inactive'
  end
end
