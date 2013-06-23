# require File.dirname(__FILE__) + '/../../../../config/boot'
require 'rubygems'
require 'test/unit'
require 'mocha/setup'
require 'fetcher'
#Dir.chdir(File.dirname(__FILE__) + '/../lib/') do |d|
#  load 'fetcher/base.rb'
#  load 'fetcher/imap.rb'
#  load 'fetcher/pop.rb'
#  load 'fetcher.rb'
#end
#
class FetcherTest < Test::Unit::TestCase
  
  def setup
    @receiver = mock()
  end
  
  def test_should_set_configuration_instance_variables
    create_fetcher
    assert_equal 'test.host', @fetcher.instance_variable_get(:@server)
    assert_equal 'name', @fetcher.instance_variable_get(:@username)
    assert_equal 'password', @fetcher.instance_variable_get(:@password)
    assert_equal @receiver, @fetcher.instance_variable_get(:@receiver)
  end
  
  def test_should_require_subclass
    create_fetcher
    assert_raise(NotImplementedError) { @fetcher.fetch }
  end
  
  def test_should_require_server
    assert_raise(ArgumentError) { create_fetcher(:server => nil) }
  end
  
  def test_should_require_username
    assert_raise(ArgumentError) { create_fetcher(:username => nil) }
  end
  
  def test_should_require_password
    assert_raise(ArgumentError) { create_fetcher(:password => nil) }
  end
  
  def test_should_require_receiver
    assert_raise(ArgumentError) { create_fetcher(:receiver => nil) }
  end
  
  def create_fetcher(options={})
    @fetcher = Fetcher::Base.new({:server => 'test.host', :username => 'name', :password => 'password', :receiver => @receiver}.merge(options))
  end
  
end

class FactoryFetcherTest < Test::Unit::TestCase
  
  def setup
    @receiver = mock()
    @pop_fetcher = Fetcher.create(:type => :pop, :server => 'test.host',
                               :username => 'name',
                               :password => 'password',
                               :receiver => @receiver)
    
  @imap_fetcher = Fetcher.create(:type => :imap, :server => 'test.host',
                              :username => 'name',
                              :password => 'password',
                              :receiver => @receiver)
  end
  
  def test_should_be_sublcass
    assert_equal Fetcher::Pop, @pop_fetcher.class
    assert_equal Fetcher::Imap, @imap_fetcher.class
  end
  
  def test_should_require_type
    assert_raise(ArgumentError) { Fetcher.create({}) }
  end
  
  def test_should_accept_scope
    # pending
  end
  
  def test_should_accept_empty_scope
    # pending
  end
end

# Write tests for sub-classes

class ImapFetcherTest < Test::Unit::TestCase
  
  def setup
    @receiver = mock()
    
    @fetcher = Fetcher.create(:type => :imap, :server => 'test.host',
                              :username => 'name',
                              :password => 'password',
                              :receiver => @receiver)
  end
  
  def test_should_accept_scope
    # pending
  end
  
  def test_should_accept_empty_scope
    # pending
  end
  
  def test_should_accept_scope_within_rfc_3501_v4_r1
    SEARCH_FLAGS = ['DELETED', 'DRAFT', 'FLAGGED', 'NEW', 'OLD', 'RECENT', "SEEN", 'UNANSWERED', 'UNDELETED', 'UNDRAFT', 'UNFLAGGED', 'UNSEEN'] # RFC 3501 v.4rev1
    # pending
  end
end

class PopFetcherTest < Test::Unit::TestCase
  
  def setup
    @receiver = mock()
    
    @fetcher = Fetcher.create(:type => :pop, :server => 'test.host',
                              :username => 'name',
                              :password => 'password',
                              :receiver => @receiver)
  end
  
  def test_should_accept_scope
    # pending
  end
  
  def test_should_accept_empty_scope
    # pending
  end
end

