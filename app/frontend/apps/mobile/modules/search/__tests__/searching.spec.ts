// Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

import { getTestRouter } from '@tests/support/components/renderComponent'
import { visitView } from '@tests/support/components/visitView'
import type { MockGraphQLInstance } from '@tests/support/mock-graphql-api'
import { mockPermissions } from '@tests/support/mock-permissions'
import { waitUntil } from '@tests/support/utils'
import { mockSearchOverview } from '../graphql/mocks/mockSearchOverview'

describe('visiting search page', () => {
  let mockSearchApi: MockGraphQLInstance

  beforeEach(() => {
    mockSearchApi = mockSearchOverview([])
    mockPermissions(['ticket.agent'])
  })

  it('doesnt search if no type is selected', async () => {
    const view = await visitView('/search')

    const searchInput = view.getByPlaceholderText('Search…')
    await view.events.type(searchInput, 'search')

    expect(mockSearchApi.spies.resolve).not.toHaveBeenCalled()
  })

  it('allows searching', async () => {
    const view = await visitView('/search')

    const searchInput = view.getByPlaceholderText('Search…')

    expect(searchInput).toHaveFocus()
    expect(view.getByTestId('selectTypesSection')).toBeInTheDocument()

    await view.events.click(view.getByText('Users'))

    expect(view.container).toHaveTextContent('Enter more than two characters')

    await view.events.type(searchInput, 'search')

    await waitUntil(() => mockSearchApi.calls.resolve)

    expect(mockSearchApi.spies.resolve).toHaveBeenCalledWith({
      onlyIn: 'User',
      isAgent: true,
      search: 'search',
    })

    expect(view.getByTestId('buttonPills')).toBeInTheDocument()
    expect(view.container).toHaveTextContent('No entries')

    await view.events.click(view.getByText('Organizations'))

    expect(mockSearchApi.spies.resolve).toHaveBeenCalledWith({
      onlyIn: 'Organization',
      isAgent: true,
      search: 'search',
    })

    expect(view.getByPlaceholderText('Search…')).toHaveFocus()
  })

  it('renders correctly if queries are passed down', async () => {
    const view = await visitView('/search/invalid?search=search')

    expect(view.getByPlaceholderText('Search…')).toHaveDisplayValue('search')
    expect(view.getByTestId('selectTypesSection')).toBeInTheDocument()
  })

  it('opens with type, if there is only single type', async () => {
    // customer can only search for tickets
    mockPermissions(['ticket.customer'])
    await visitView('/search')
    expect(getTestRouter().currentRoute.value.fullPath).toBe('/search/ticket')
  })
})
