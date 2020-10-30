# frozen_string_literal: true

RSpec.shared_examples 'POST authenticated examples' do |resource, namespace|
  describe 'POST' do
    let!(:model) { resource.to_s.classify.safe_constantize }
    let!(:valid_attributes) { attributes_for resource.to_s.singularize.to_sym }
    let!(:invalid_attributes) { attributes_for resource.to_s.singularize.to_sym, :invalid }

    context 'with an authenticated user' do
      before do
        sign_in_user
      end

      context 'with valid attributes' do
        it "adds a #{resource}" do
          expect do
            post send(url_for(resource, namespace: namespace)), params: { user: valid_attributes }
          end.to change(model.all, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it "does not add a #{resource}" do
          expect do
            post send(url_for(resource, namespace: namespace)), params: { user: invalid_attributes }
          end.not_to change(model.all, :count)
        end
      end
    end

    context 'with a guest' do
      context 'with valid attributes' do
        it "does not add a #{resource}" do
          expect do
            post send(url_for(resource, namespace: namespace)), params: { user: valid_attributes }
          end.not_to change(model.all, :count)
        end
      end

      context 'with invalid attributes' do
        it "does not add a #{resource}" do
          expect do
            post send(url_for(resource, namespace: namespace)), params: { user: invalid_attributes }
          end.not_to change(model.all, :count)
        end
      end
    end
  end
end
