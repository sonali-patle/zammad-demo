# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

require 'rails_helper'

RSpec.describe Gql::Queries::AutocompleteSearch::User, type: :graphql, authenticated_as: :agent do

  context 'when searching for users' do
    let(:agent)        { create(:agent) }
    let(:users)        { create_list(:agent, 3, lastname: 'AutocompleteSearch') }
    let(:query)        { gql.read_files('shared/graphql/queries/autocompleteSearch/user.graphql') }
    let(:variables)    { { query: query_string, limit: limit } }
    let(:query_string) { users.last.lastname }
    let(:limit)        { nil }

    before do
      gql.execute(query, variables: variables)
    end

    context 'without limit' do
      it 'finds all users' do
        expect(gql.result.data.length).to eq(users.length)
      end
    end

    context 'with limit' do
      let(:limit) { 1 }

      it 'respects the limit' do
        expect(gql.result.data.length).to eq(limit)
      end
    end

    context 'with exact search' do
      let(:first_user_payload) do
        {
          'value'              => gql.id(users.first),
          'label'              => users.first.fullname,
          'labelPlaceholder'   => nil,
          'heading'            => nil,
          'headingPlaceholder' => nil,
          'icon'               => nil,
          'disabled'           => nil,
        }
      end
      let(:query_string) { users.first.login }

      it 'has data' do
        expect(gql.result.data).to eq([first_user_payload])
      end
    end

    context 'when sending an empty search string' do
      let(:query_string) { '   ' }

      it 'returns nothing' do
        expect(gql.result.data.length).to eq(0)
      end
    end

    it_behaves_like 'graphql responds with error if unauthenticated'
  end
end
