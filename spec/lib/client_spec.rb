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
        subject.search
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
      it 'performs the GET request to the correct endpoint' do
        expect(subject).to receive(:get).with('GetCategoryList', {'ShopId'=>0})
        subject.categories
      end

      it 'returns a Affilinet::Middleware::Mash' do
        expect(subject.categories).to be_an_instance_of Affilinet::Middleware::Mash
      end
    end

    describe '#properties' do
      it 'performs the GET request to the correct endpoint' do
        expect(subject).to receive(:get).with('GetPropertyList', {'ShopId'=>1})
        subject.properties 1
      end

      it 'returns a Affilinet::Middleware::Mash' do
        expect(subject.properties 1748).to be_an_instance_of Affilinet::Middleware::Mash
      end
    end

    describe '#products' do
      it 'performs the GET request to the correct endpoint' do
        expect(subject).to receive(:get).with('GetProducts', {"ProductIds"=>"",
          "ImageScales"=>"", "LogoScales"=>""})
        subject.products
      end

      it 'returns a Affilinet::Middleware::Mash' do
        expect(subject.products [580858761,580858759]).to be_an_instance_of Affilinet::Middleware::Mash
      end
    end

    describe '#search' do
      it 'performs the GET request to the correct endpoint' do
        expect(subject).to receive(:get).with('SearchProducts', {"ShopIds"=>"",
          "ShopIdMode"=>"Include", "Query"=>nil, "CategoryIds"=>"",
          "UseAffilinetCategories"=>nil, "ExcludeSubCategories"=>nil,
          "WithImageOnly"=>nil, "ImageScales"=>"", "LogoScales"=>"",
          "CurrentPage"=>nil, "PageSize"=>nil, "MinimumPrice"=>nil,
          "MaximumPrice"=>nil, "SortBy"=>nil, "SortOrder"=>"descending",
          "FacetFields"=>"", "FacetValueLimit"=>nil, "FQ"=>nil})
        subject.search
      end

      it 'returns a Affilinet::Middleware::Mash' do
        expect(subject.search query: 'jeans').to be_an_instance_of Affilinet::Middleware::Mash
      end
    end
  end
end
