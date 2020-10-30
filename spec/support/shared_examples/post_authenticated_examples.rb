# frozen_string_literal: true

RSpec.shared_examples 'POST authenticated' do
  describe 'POST' do
    include_context 'with POST setup'

    context 'with an authenticated user' do
      before do
        sign_in_user
      end

      context 'with valid attributes' do
        it 'adds a resource' do
          expect do
            post send(url_for(action: :create)), params: { user: valid_attributes }
          end.to change(model.all, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        include_examples 'does not add a resource'
      end
    end

    context 'with a guest' do
      context 'with valid attributes' do
        it 'does not add a resource' do
          expect do
            post send(url_for(action: :create)), params: { user: valid_attributes }
          end.not_to change(model.all, :count)
        end
      end

      context 'with invalid attributes' do
        include_examples 'does not add a resource'
      end
    end
  end
end
