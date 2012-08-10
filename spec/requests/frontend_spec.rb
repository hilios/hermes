require 'spec_helper'

describe Hermes::Frontend do
  let(:website) { FactoryGirl.create(:website) }
  
  # Delegate request to website host
  before do
    rack_test_session.instance_variable_set(:@default_host, website.domains.first.to_s.gsub(/https?\:\/\//, ''))
  end
  
  # Switch to sinatra
  def app
    Hermes::Frontend
  end
  
  it "throws a 404 with asked for a not registered website" do
    get "http://bad.uri.com/"
    last_response.should be_not_found
  end

  describe Resource do
    context Asset::Static do
      it "returns the resource" do
        image = FactoryGirl.create(:image, website: website, parent: FactoryGirl.create(:folder))
        get image.path
        last_response.should be_ok
      end
    end
  end
end
