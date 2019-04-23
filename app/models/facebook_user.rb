class FacebookUser

  def initialize(provider)
    @provider = provider
  end

  def pages
    if !@provider.expired? && @provider.facebook?
      graph = Koala::Facebook::API.new(@provider.token)
      pages = graph.get_connections("me", "accounts")
    end
    pages ||= []
  end
end
