#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
module Support::ParamsHelper
	#
	def session_param(context, key, default = nil)
		handle_session_param(context, key, default)
	end

	#
	def page_param(context, per_page)
		session_param(context, :page, 1)
		session_param(context, :per_page, per_page)
	end

	#
	def sort_param(context,  attribute, order)
		session_param(context, :sort_attribute, attribute)
		session_param(context, :sort_order, order)
	end

	#
	def filter_param(context)
		session_param(context, :filter_attribute)
		session_param(context, :filter_value)
	end

private
	#
	def handle_session_param(context, key, default)
		session[context] ||= {}
		value = params.include?(key) ? params[key] : session[context][key] || default
		value = value.to_s if !value.nil?
		instance_variable_set("@#{key}".to_sym, value)
		session[context][key] = value
	end
end
