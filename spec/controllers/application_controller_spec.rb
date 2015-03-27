require 'spec_helper'

describe Api::V1::ItemsController, :type => :controller do
  describe '#parse_params' do
    it 'coerces string true and false to boolean true/fase' do
      subject.params = {
        truthy: 'true',
        falsey: 'false'
      }

      expect(subject.params["truthy"]).not_to be true
      expect(subject.params["falsey"]).not_to be false

      subject.parse_params

      expect(subject.params["truthy"]).to be true
      expect(subject.params["falsey"]).to be false
    end
  end
end
