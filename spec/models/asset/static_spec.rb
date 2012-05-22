require 'spec_helper'

describe Asset::Static do
  describe "collection" do
    it { should have_field(:content_type).of_type(String) }
    it { should have_field(:body) } # It is a String but not until Carrierwave process
  end
end
