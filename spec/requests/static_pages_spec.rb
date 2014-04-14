require 'spec_helper'

describe "StaticPages" do
	subject { page }

  describe "Home" do
  	before { visit root_path }

    it { should have_content('Quicker') }
  end
end
