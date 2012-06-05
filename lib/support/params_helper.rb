# -*- encoding : utf-8 -*-
module Support::ParamsHelper
	#
	def session_param(context, key, default = nil)
		handle_session_value(context, key, default)
	end

	#
	def page_param(context)
		handle_session_value(context, :page, 1)
	end

	#
	def sort_param(context, key, order)
		handle_session_symbol(context, :sort_key, key)
		handle_session_symbol(context, :sort_order, order)
	end

	#
	def filter_param(context)
		handle_session_symbol(context, :filter_key, "")
		handle_session_value(context, :filter_value, "")
	end

	#
	def handle_session_value(context, key, default)
		handle_session_param(context, key, default)
	end

	#
	def handle_session_symbol(context, key, default)
		handle_session_param(context, key, default) { |value| value.to_sym if value}
	end

	#
	def handle_session_param(context, key, default, &block)
		session[context] ||= {}
		value = params[key] || session[context][key] || default
		value = yield(value) if block_given?
		instance_variable_set("@#{key}".to_sym, value)
		session[context][key] = value
	end
end
