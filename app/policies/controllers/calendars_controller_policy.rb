# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

class Controllers::CalendarsControllerPolicy < Controllers::ApplicationControllerPolicy
  permit! :timezones, to: 'admin'
  default_permit!('admin.calendar')
end
