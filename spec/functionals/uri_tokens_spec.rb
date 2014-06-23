require 'spec_helper'

describe ServiceApi::UriTokens do
  describe 'default' do
    let(:template) { ServiceApi::UriTokens.new('http://{host}/{segments}/{file}.{extensions}') }

    it 'should use RFC6570 class' do
      template.uri_template.class.should == URITemplate::RFC6570
    end

    it 'should return token values' do
      template.token_values.sort.should == ['host', 'segments', 'file', 'extensions'].sort
    end
  end

  describe 'colon' do
    let(:template) { ServiceApi::UriTokens.new(:colon, 'http://:host/:segments/:file.:extensions') }

    it 'should use Colon class' do
      template.uri_template.class.should == URITemplate::Colon
    end

    it 'should return token values' do
      template.token_values.sort.should == ['host', 'segments', 'file', 'extensions'].sort
    end
  end
end
