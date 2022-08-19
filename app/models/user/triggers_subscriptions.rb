# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

# Trigger GraphQL subscriptions on user changes.
module User::TriggersSubscriptions
  extend ActiveSupport::Concern

  included do
    after_update :trigger_subscriptions
  end

  private

  def trigger_subscriptions
    # return if we run import mode
    return true if Setting.get('import_mode')

    Gql::Subscriptions::UserUpdates.trigger(self, arguments: { user_id: Gql::ZammadSchema.id_from_object(self) })
  end
end
