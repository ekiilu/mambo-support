# -*- encoding : utf-8 -*-
module Support::FormHelper
	#
	def options_for_enum(enum, val = nil)
		options_for_select(enum.options[:flags].map {|option| [option.capitalize, option]}, val)
	end

  def submit_form
    "javascript: this.form.submit();"
  end

  def active_class(bool)
    bool ? 'active' : 'inactive'
  end
end
