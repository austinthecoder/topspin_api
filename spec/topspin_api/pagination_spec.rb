require 'spec_helper'

describe TopspinApi::Pagination do

  before :all do
    @klass = Class.new.send :include, described_class
  end

  subject { @klass.new }

  describe "decorate" do
    context "given a hash-like object with pagination-related keys" do
      before do
        @hash = {'total_pages' => 52, 'current_page' => 14, 'total_entries' => 362, 'per_page' => 7}
        @obj = Object.new
      end

      it "adds these keys as methods to the given object" do
        subject.decorate @hash, @obj
        @obj.total_pages.should == 52
        @obj.current_page.should == 14
        @obj.total_entries.should == 362
        @obj.per_page.should == 7
      end

      it "returns the object" do
        subject.decorate(@hash, @obj).should == @obj
      end

      it "converts the hash values to integers as needed" do
        @hash['per_page'] = '7'
        subject.decorate(@hash, @object).per_page.should == 7
      end

      it "gracefully handles missing keys" do
        @hash.delete 'total_pages'
        expect { subject.decorate(@hash, @obj) }.to_not raise_error
      end
    end

    context "without a hash-like object" do
      it "raises NoMethodError" do
        expect { subject.decorate Object.new, Object.new }.to raise_error(NoMethodError)
      end
    end
  end

end