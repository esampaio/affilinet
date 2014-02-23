require 'spec_helper'

describe Affilinet::Search do
  subject { Affilinet::Search.new double('Affilinet::Client') }

  describe '#all' do
    it 'correctly queries the client' do
      expect(subject.client).to receive(:get).with('SearchProducts', {'query' => 'jeans'})
      subject.query('jeans').all
    end
  end
end
