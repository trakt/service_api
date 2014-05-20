require 'spec_helper'

describe ServiceApi::UriTokens do
  let(:template) { ServiceApi::UriTokens.new('http://{host}/{segments}/{file}.{extensions}') }

  it 'should return token values' do
    template.token_values.sort.should == ['extensions', 'file', 'host', 'segments']
  end
end
