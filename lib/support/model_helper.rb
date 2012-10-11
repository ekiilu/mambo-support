#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Support::ModelHelper
	#
	def self.included(base)
		base.extend(ClassMethods)
	end

	module ClassMethods
		# for table filtering
		def filtered_by(key, value)
			return where{true} if value.blank?
			# turn dot notation string into a keypath by invoking each element in the context of the squeel dsl
			where{
				key
				.split('.')
				.inject(self) do |keypath, element|
					keypath.__send__(element)
				end
				.eq(value)
			}
		end

		# for table sorting
		def sorted_by(key, order)
			return where{true} if key.blank?
			# turn dot notation string into a keypath by invoking each element in the context of the squeel dsl
			order{
				key
				.split('.')
				.inject(self) do |keypath, element|
					keypath.__send__(element)
				end
				.__send__(order)
			}
		end
	end
end
