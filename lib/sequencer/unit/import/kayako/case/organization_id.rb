# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

class Sequencer
  class Unit
    module Import
      module Kayako
        module Case
          class OrganizationId < Sequencer::Unit::Common::Provider::Named

            uses :resource, :id_map

            private

            def organization_id
              return if organization.nil?

              id_map['Organization'][organization['id']]
            end

            def organization
              resource['requester']&.fetch('organization')
            end
          end
        end
      end
    end
  end
end
