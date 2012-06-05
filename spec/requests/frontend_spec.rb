require 'spec_helper'

describe Hermes::Frontend do
  # Switch to sinatra
  def app
    Hermes::Frontend
  end

  describe Resource do
    context Asset::Static do
      it "does" do
        image = FactoryGirl.create(:image, :parent => FactoryGirl.create(:folder))
        get image.uri
        last_response.should be_ok
      end
    end
  end
end