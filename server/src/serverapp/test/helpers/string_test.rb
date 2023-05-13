require_relative '../../app/helpers/string'

class StringTest < ActiveSupport::TestCase

    test  'can add querystring when empty' do
        url = 'https://www.unittest94234.com/path/abc' 
        assert_equal 'https://www.unittest94234.com/path/abc?test_key=test_value', 
            url.set_query_value('test_key','test_value')
    end 

    test  'can add querystring when not empty' do
        url = 'https://www.unittest94234.com/path/abc?fake=123' 
        assert_equal 'https://www.unittest94234.com/path/abc?fake=123&test_key=test_value', 
            url.set_query_value('test_key','test_value')
    end 

    test  'can add querystring when already exists empty' do
        url = 'https://www.unittest94234.com/path/abc?fake=123&test_key=wrong' 
        assert_equal 'https://www.unittest94234.com/path/abc?fake=123&test_key=test_value', 
            url.set_query_value('test_key','test_value')
    end 

    test  'can remove querystring' do
        url = 'https://www.unittest94234.com/path/abc?test_key=wrong' 
        assert_equal 'https://www.unittest94234.com/path/abc', 
            url.set_query_value('test_key',nil)
    end 


end 