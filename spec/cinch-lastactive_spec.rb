require 'spec_helper'

describe Cinch::Plugins::LastActive do
  include Cinch::Test

  before(:each) do
    @bot = make_bot(Cinch::Plugins::LastActive, { filename: '/dev/null' })
  end

  it 'should not respond to activiy via pm' do
    msg = make_message(@bot, '')
    expect(get_replies(msg, :join))
      .to be_empty
  end

  it 'should not respond to activiy via pm' do
    msg = make_message(@bot, '', { channel: '#foo' })
    expect(get_replies(msg, :join).first.text)
      .to match(/Hello, test. The last activity was \d seconds ago/)
  end
end
