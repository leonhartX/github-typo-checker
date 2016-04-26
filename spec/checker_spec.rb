require 'spec_helper'

describe Typochecker::Checker do
  it 'has a valid client' do
    checker = Typochecker::Checker.new
    expect(checker).not_to be nil
  end

  it "has scope" do
    checker = Typochecker::Checker.new
    expect(checker.scope).to be nil
    checker.scope = "leonhartx"
    expect(checker.scope).to eq "leonhartx"
  end
end