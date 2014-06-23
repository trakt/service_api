require 'spec_helper'

class Client
  def options
    { adapter: :test, adapter_options: faraday_stubs }
  end

  def faraday_stubs
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/test/request?api_key=abcd&sample=true') { [200, {}, 'OK'] }
    end
  end
end

class MyApi
  include ServiceApi::BaseFaraday

  private

  def base_url
    'http://example.com'
  end
end

class SampleApi < MyApi
  def find
    path('/test/{request}').params(api_key: 'abcd', sample: true, request: 'request').get
  end

  def find_url
    path('/test/request').params(api_key: 'abcd', sample: true).url
  end
end

class Sample2Api < MyApi
  def find
    path('/test/:request').params(api_key: 'abcd', sample: true, request: 'request').get
  end

  def find_url
    path('/test/request').params(api_key: 'abcd', sample: true).url
  end

  def uri_kind
    :colon
  end
end

describe ServiceApi::BaseFaraday do
  let(:client) { Client.new }
  let(:model) { SampleApi.new(client) }
  let(:model2) { Sample2Api.new(client) }

  describe 'model' do
    it 'should return string' do
      model.find.body.should == 'OK'
    end

    it 'should return full url' do
      model.find_url.should == 'http://example.com/test/request?api_key=abcd&sample=true'
    end
  end

  describe 'model2' do
    it 'should return string' do
      model2.find.body.should == 'OK'
    end

    it 'should return full url' do
      model2.find_url.should == 'http://example.com/test/request?api_key=abcd&sample=true'
    end
  end
end
