# frozen_string_literal: true

require 'legion/extensions/abductive_reasoning/helpers/constants'
require 'legion/extensions/abductive_reasoning/helpers/observation'
require 'legion/extensions/abductive_reasoning/helpers/hypothesis'
require 'legion/extensions/abductive_reasoning/helpers/abduction_engine'
require 'legion/extensions/abductive_reasoning/runners/abductive_reasoning'

module Legion
  module Extensions
    module AbductiveReasoning
      class Client
        include Runners::AbductiveReasoning

        def initialize(engine: nil)
          @engine = engine || Helpers::AbductionEngine.new
        end
      end
    end
  end
end
