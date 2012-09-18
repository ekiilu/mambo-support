#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
module Support::ParamsHelper
	#
	def session_param_value(context, key, default = nil)
		handle_session_param_value(context, key, default)
	end

	def session_param_symbol(context, key, default = nil)
		handle_session_param_symbol(context, key, default)
	end

	#
	def page_param(context, per_page)
		session_param_value(context, :page, 1)
		session_param_value(context, :per_page, per_page)
	end

	#
	def sort_param(context, association, attribute, order)
		session_param_symbol(context, :sort_association, association)
		session_param_symbol(context, :sort_attribute, attribute)
		session_param_symbol(context, :sort_order, order)
	end

	#
	def filter_param(context)
		session_param_symbol(context, :filter_association)
		session_param_symbol(context, :filter_attribute)
		session_param_value(context, :filter_value)
	end

	#
	def handle_session_param_value(context, key, default, &block)
		session[context] ||= {}
		value = params.include?(key) ? params[key] : session[context][key] || default
		value = yield(value) if block_given?
		instance_variable_set("@#{key}".to_sym, value)
		session[context][key] = value
	end

	def handle_session_param_symbol(context, key, default)
		handle_session_param_value(context, key, default) { |value| value.blank? ? value : value.to_sym }
	end
end
