require 'spec_helper'

describe Affilinet::Property do
  subject { Affilinet::Property.new double('Affilinet::Client') }

  describe '#all' do
    it 'correctly queries the client' do
      expect(subject.client).to receive(:get).with('GetPropertyList', {'ShopId' => 0})
      subject.shop_id(0).all
    end
  end
end
