class MockSessionFactory
  def initialize(cookies)
    @cookies = cookies
    @mock_session = cookies['rack.session']
    if @mock_session
      @mock_session = @mock_session.unpack(*'m').first
      @mock_session = Marshal.load(@mock_session)
    else
      @mock_session = {}
    end
  end

  def [](key)
    @mock_session[key]
  end

  def []=(key, value)
    @mock_session[key] = value
    session_session = Marshal.dump(@mock_session)
    session_session = [session_session].pack("m*")
    @cookies.merge("rack.session=#{Rack::Utils.escape(session_session)}")
    raise "session variable not set" unless @cookies['rack.session'] == session_session
  end
end