require 'spec_helper'

describe Affilinet::Client, :vcr do
  it 'raises ArgumentError if initialized with no options' do
    expect do
      Affilinet::Client.new
    end.to raise_error ArgumentError
  end

  context 'initialized with credentials' do
    subject { Affilinet::Client.new publisher_id: 580442, password: '1TuKEGkOJJ24dN07ByOy' }

    it 'raises Faraday::Error::ParsingError on wrong API requests' do
      expect do
        subject.search.all
      end.to raise_error Faraday::Error::ParsingError
    end

    describe '#connection' do
      it 'is an instance of Faraday::Connection' do
        expect(subject.connection).to be_an_instance_of Faraday::Connection
      end
    end

    describe '#options' do
      it 'includes publisher_id' do
        expect(subject.options).to include(:publisher_id)
      end

      it 'includes password' do
        expect(subject.options).to include(:password)
      end
    end

    describe '#categories' do
      it 'returns a Affilinet::Middleware::Mash' do
        expect(subject.categories.shop_id(0).all).to be_an_instance_of Affilinet::Middleware::Mash
      end
    end

    describe '#properties' do
      it 'returns a Affilinet::Middleware::Mash' do
        expect(subject.properties.shop_id(1748).all).to be_an_instance_of Affilinet::Middleware::Mash
      end
    end

    describe '#shops' do
      it 'returns a Affilinet::Middleware::Mash' do
        expect(subject.shops.all).to be_an_instance_of Affilinet::Middleware::Mash
      end
    end

    describe '#products' do
      it 'returns a Affilinet::Middleware::Mash' do
        expect(subject.products.product_ids([580858761,580858759]).all).to be_an_instance_of Affilinet::Middleware::Mash
      end
    end

    describe '#search' do
      it 'returns a Affilinet::Middleware::Mash' do
        expect(subject.search.query('jeans').all).to be_an_instance_of Affilinet::Middleware::Mash
      end
    end
  end
end
