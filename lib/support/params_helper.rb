# -*- encoding : utf-8 -*-
module Support::ParamsHelper
	#
	def session_param(context, key, default = nil)
		handle_session_param(context, key, default)
	end

	#
	def page_param(context)
		handle_session_param(context, :page, 1)
	end

	#
	def sort_param(context, key, order)
		handle_session_param(context, :sort_key, key)
		handle_session_param(context, :sort_order, order)
	end

	#
	def filter_param(context)
		handle_session_param(context, :filter_key, :none)
		handle_session_param(context, :filter_value, "")
	end

	#
	def handle_session_param(context, key, default)
		session[context] ||= {}
		value = params[key] || session[context][key] || default
		value = value.to_sym if !value.nil? && default.is_a?(Symbol)
		instance_variable_set("@#{key}".to_sym, value)
		session[context][key] = value
	end
end
