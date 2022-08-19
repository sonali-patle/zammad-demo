# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

require 'rails_helper'

RSpec.describe 'Mobile > Tickets', type: :system, app: :mobile, authenticated_as: :agent do
  let(:organization)     { create(:organization) }
  let(:user)             { create(:user, organization: organization) }
  let(:group)            { create(:group) }
  let(:agent)            { create(:agent) }
  let(:open_tickets)     { create_list(:ticket, 20, customer: user, organization: organization, group: group, created_by_id: user.id, state: Ticket::State.lookup(name: 'open')) }
  let(:overview_tickets) { ::Ticket::Overviews.tickets_for_overview(Overview.find_by(link: 'all_open'), agent).limit(nil) }

  before do
    Overview.find_by(link: 'all_open').update!(
      view: {
        s:                 %w[number title customer group state owner created_at],
        view_mode_default: 's',
      },
    )

    open_tickets
    overview_tickets

    agent.group_names_access_map = Group.all.to_h { |g| [g.name, ['full']] }
  end

  context 'when on "Open Tickets" view' do
    before do
      visit '/tickets/view/all_open'
    end

    context 'when checking displayed tickets' do
      it 'displays 10 tickets by default' do
        expect(page).to have_link(href: %r{/mobile/tickets/}, count: 10)
      end

      it 'loads more tickets when scrolling down' do
        wait.until do
          expect(page).to have_link(href: %r{/mobile/tickets/}, count: 10)
        end

        page.scroll_to :bottom

        wait.until do
          expect(page).to have_link(href: %r{/mobile/tickets/}, count: 20)
        end
      end
    end

    context 'when changing sort by and order by' do
      it 'opens the dialog and reorders the list' do
        wait.until do
          expect(page).to have_css('[data-test-id="column"]')
        end

        find('[data-test-id="column"]').click

        wait.until do
          expect(page).to have_css('[role="dialog"]')
          expect(page.find('[role="dialog"]')).to have_text('Number')
          expect(page.find('[role="dialog"]')).to have_text('descending')
        end

        find('span', text: 'Number').click
        find('label', text: 'descending').click

        send_keys(:escape)

        wait.until do
          expect(page).to have_no_css('[role="dialog"]')
        end

        expect(find('a[href^="/mobile/tickets/"]:first-of-type')).to have_text(open_tickets.last.number)
      end
    end

    context 'when changing the selected ticket overview' do
      before do
        visit '/'
      end

      it 'could change the overview' do
        wait.until do
          expect(page).to have_link('Open Tickets', href: '/mobile/tickets/view/all_open')
        end

        find_link('Open Tickets', href: '/mobile/tickets/view/all_open').click

        wait.until do
          expect(page).to have_text("Open Tickets\n(21)")
        end

        find('output[name="overview"]').click

        wait.until do
          expect(page).to have_css('[role="dialog"]')
          expect(page.find('[role="dialog"]')).to have_text('Escalated Tickets')
        end

        find('span', text: 'Escalated Tickets').click

        wait.until do
          expect(page).to have_no_css('[role="dialog"]')
          expect(page).to have_text("Escalated Tickets\n(0)")
        end
      end
    end
  end
end
