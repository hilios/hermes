require 'spec_helper'

describe FileSystem do
  describe "collection" do
    it { should have_field(:url).of_type(String) }
  end
end
