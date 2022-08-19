# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

# Trigger GraphQL subscriptions on ticket changes.
module Ticket::TriggersSubscriptions
  extend ActiveSupport::Concern

  included do
    after_update :trigger_subscriptions
  end

  private

  def trigger_subscriptions
    # return if we run import mode
    return true if Setting.get('import_mode')

    Gql::Subscriptions::TicketUpdates.trigger(self, arguments: { ticket_id: Gql::ZammadSchema.id_from_object(self) })
  end
end
