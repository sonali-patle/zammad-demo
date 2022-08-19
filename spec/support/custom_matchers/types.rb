# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

RSpec::Matchers.define :be_a_uuid do
  match do |actual|
    c = '[a-z0-9-]'
    actual.match %r{^#{c}{8}-#{c}{4}-#{c}{4}-#{c}{4}-#{c}{12}$}i
  end
end
