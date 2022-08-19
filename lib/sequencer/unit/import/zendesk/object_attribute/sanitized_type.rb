# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

class Sequencer
  class Unit
    module Import
      module Zendesk
        module ObjectAttribute
          class SanitizedType < Sequencer::Unit::Base
            include ::Sequencer::Unit::Import::Common::Model::Mixin::HandleFailure
            prepend ::Sequencer::Unit::Import::Common::Model::Mixin::Skip::Action

            skip_action :skipped, :failed

            uses :resource
            provides :backend_class

            private

            def process
              state.provide(:backend_class, backend_class)
            rescue => e
              handle_failure(e)
            end

            def backend_class
              "Sequencer::Unit::Import::Zendesk::ObjectAttribute::AttributeType::#{resource.type.capitalize}".constantize
            end
          end
        end
      end
    end
  end
end
