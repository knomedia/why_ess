class Yelp::Utils

  YELP_CACHE_HOURS = ENV.fetch('YELP_CACHE_HOURS', 24).to_i

  attr_accessor :uuid
  attr_accessor :business
  attr_accessor :status

  def initialize(uuid)
    @uuid = uuid
    @status = 200
  end

  def get_business
    load_by_uuid
    reload_from_yelp unless valid_cache?
    @business
  end

  def valid_cache?
    !empty? && !expired?
  end

  def empty?
    @business.nil? || @business.expires_at.nil? || @business.listing.empty?
  end

  def expired?
    @business.expires_at < YELP_CACHE_HOURS.hours.ago
  end

  def reload_from_yelp
    @status, listing = Yelp::Client.new(@uuid).listing
    if @status == 200
      @business.listing = listing
      @business.expires_at = YELP_CACHE_HOURS.hours.from_now
      @business.save!
    end
  end

  def load_by_uuid
    @business = Business.where(uuid: @uuid).limit(1).first
    @business ||= Business.new(uuid: @uuid)
  end

end
