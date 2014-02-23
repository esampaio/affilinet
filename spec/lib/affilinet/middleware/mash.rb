require 'spec_helper'

describe Affilinet::Middleware::Mash do
  subject { Affilinet::Middleware::Mash }

  describe '::join_arrays' do
    it 'joins array values using a comma' do
      foo = {bar: ['baz', 'fubar']}
      expect(subject.join_arrays foo).to eq({bar: 'baz,fubar'})
    end
  end

  describe '::camelize_keys' do
    it 'camelizes all the keys' do
      foo = {foo_bar: 'foo', f_q: 'bar'}
      expect(subject.camelize_keys foo).to eq({'FooBar' => 'foo', 'FQ' => 'bar'})
    end
  end

  describe '::camelize' do
    it 'camelizes words' do
      expect(subject.camelize :foo_bar_baz).to eq('FooBarBaz')
    end
  end

  describe '::underscore' do
    it 'underscores words' do
      expect(subject.underscore 'FooBarBaz').to eq('foo_bar_baz')
    end
  end
end
