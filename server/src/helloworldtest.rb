require 'rspec'

class SomethingToTest 
    def doSomething(x)
        return "you said #{x}"
    end 
end 

RSpec.describe SomethingToTest do
    describe '#doSomething' do
        context do
            sut = SomethingToTest.new
            [
                { input: "ABC", output: "you said ABC" },
                { input: "XYZ", output: "you said XYZ" },
            ].each do |test_case|
                it "should say something" do                
                    expect(sut.doSomething(test_case[:input])).to eq(test_case[:output])
                end
            end 
        end
    end 
end  
