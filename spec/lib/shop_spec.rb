require 'spec_helper'

describe Affilinet::Shop do
  subject { Affilinet::Shop.new double('Affilinet::Client') }

  [:logo_scale, :current_page, :page_size, :updated_after, :query].each do |attr|
    describe "##{attr}" do
      it "sets the #{attr}" do
        shop = subject.send(attr, 'foo')
        expect(shop.criteria[attr]).to eq('foo')
      end

      it "replaces the #{attr}" do
        shop = subject.send(attr, 'bar')
        expect(shop.criteria[attr]).to eq('bar')
        shop = subject.send(attr, 'baz')
        expect(shop.criteria[attr]).to eq('baz')
      end
    end
  end

  describe 'fluent interface basics' do
    it 'successfully chains methods' do
      shop = subject.current_page(4).page_size(50)
      expect(shop.criteria[:current_page]).to eq(4)
      expect(shop.criteria[:page_size]).to eq(50)
    end

    it 'spawns new instances for every chained method' do
      shop = subject.current_page(2)
      shop_first = shop.page_size(50)
      shop_second = shop.page_size(50)
      expect(shop_first).not_to equal(shop_second)
      expect(shop_first.criteria[:current_page]).to eq(shop_second.criteria[:current_page])
    end
  end

  describe '#to_query' do
    it 'generates the correct Hash' do
      shop = subject.current_page(1).page_size(100)
      expect(shop.to_query).to eq({'PageSize' => 100, 'CurrentPage' => 1})
    end
  end

  describe '#all' do
    it 'correctly queries the client' do
      expect(subject.client).to receive(:get).with('GetShopList', {'CurrentPage' => 2})
      subject.current_page(2).all
    end
  end

  describe '#first' do
    it 'only requests one element, correctly recalculating pagination' do
      expect(subject.client).to receive(:get).with('GetShopList', {'CurrentPage' => 71, 'PageSize' => 1})
      subject.current_page(3).page_size(35).first
    end
  end
end
