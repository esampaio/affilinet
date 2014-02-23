require 'spec_helper'

describe Affilinet::Category do
  subject { Affilinet::Category.new double('Affilinet::Client') }

  describe '#all' do
    it 'correctly queries the client' do
      expect(subject.client).to receive(:get).with('GetCategoryList', {'ShopId' => 0})
      subject.shop_id(0).all
    end
  end
end
