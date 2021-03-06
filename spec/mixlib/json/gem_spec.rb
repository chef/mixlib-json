#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2010 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", '/spec_helper'))

describe "Mixlib::JSON::Gem" do
  describe "is_loaded?" do
    it "should return false if the JSON gem hasn't been loaded" do
      # Sigh
      Object.stub!(:const_defined?).with("JSON").and_return false
      Mixlib::JSON::Gem.is_loaded?.should == false
    end

    it "should return true if JSON gem is loaded before we are" do
      require 'json'
      Mixlib::JSON::Gem.is_loaded?.should == true
    end
  end

  describe "load" do
    it "should load return a new Mixlib::JSON::Gem object" do
      Mixlib::JSON::Gem.load.should be_a_kind_of(Mixlib::JSON::Gem)
    end
  end

  describe "generate" do
    before :each do
      Mixlib::JSON::Gem.load
      @json_obj = Mixlib::JSON::Gem.new
    end

    it "should take an object and generate JSON from it" do
      @json_obj.generate({ :one => "two" }).should == '{"one":"two"}'
    end
  end

  describe "pretty" do
    before :each do
      Mixlib::JSON::Gem.load
      @json_obj = Mixlib::JSON::Gem.new
    end

    it "should take an object and generate JSON from it" do
      @json_obj.pretty({ :one => "two" }).should == "{\n  \"one\": \"two\"\n}"
    end
  end

  describe "parse" do
    before :each do
      Mixlib::JSON::Gem.load
      @json_obj = Mixlib::JSON::Gem.new
    end

    it "should create a native ruby object from a json string" do
      @json_obj.parse('{"one":"two"}').should == { "one" => "two" }
    end
  end
end 


