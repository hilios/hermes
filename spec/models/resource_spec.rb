require 'spec_helper'

describe Resource do
  describe "collection" do
    it { should have_field(:urn).of_type(String) }

    describe "ancestry" do
      it { should have_field(:ancestry).of_type(String) }
    end
  end
end
