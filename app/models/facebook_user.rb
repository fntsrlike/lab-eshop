class FacebookUser

  def initialize(provider)
    @provider = provider
    @graph = Koala::Facebook::API.new(@provider.token)
  end

  def pages
    if !@provider.expired? && @provider.facebook?
      pages = @graph.get_connections("me", "accounts")
    end
    pages ||= []
  end
end
