# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

class Sequencer
  class Unit
    module Import
      module Freshdesk
        class ContactFields < Sequencer::Unit::Import::Freshdesk::SubSequence::Field
        end
      end
    end
  end
end