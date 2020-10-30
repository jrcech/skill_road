# frozen_string_literal: true

RSpec.shared_examples 'does not add a resource' do
  it 'does not add a resource' do
    expect do
      post url_for(action: :create), params: { user: invalid_attributes }
    end.not_to change(model.all, :count)
  end
end
