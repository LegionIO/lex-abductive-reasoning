# frozen_string_literal: true

require 'legion/extensions/abductive_reasoning/version'
require 'legion/extensions/abductive_reasoning/helpers/constants'
require 'legion/extensions/abductive_reasoning/helpers/observation'
require 'legion/extensions/abductive_reasoning/helpers/hypothesis'
require 'legion/extensions/abductive_reasoning/helpers/abduction_engine'
require 'legion/extensions/abductive_reasoning/runners/abductive_reasoning'

module Legion
  module Extensions
    module AbductiveReasoning
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
