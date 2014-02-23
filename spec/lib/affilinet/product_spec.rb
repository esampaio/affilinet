require 'spec_helper'

describe Affilinet::Product do
  subject { Affilinet::Product.new double('Affilinet::Client') }

  describe '#to_query' do
    it 'generates the correct Hash' do
      shop = subject.logo_scales(['10x2', '3x4'])
      expect(shop.to_query).to eq({'LogoScales' => '10x2,3x4'})
    end
  end

  describe '#all' do
    it 'correctly queries the client' do
      expect(subject.client).to receive(:get).with('GetProducts', {'ProductIds' => '1,2,3', 'LogoScales' => '3x4'})
      subject.logo_scales('3x4').product_ids([1, 2, 3]).all
    end
  end
end
