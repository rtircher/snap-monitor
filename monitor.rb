require 'nokogiri'
# require 'net/http'
require 'open-uri'

url = 'https://staging.snap-ci.com/JfxXS5WsVYXJpvzsGNgkyWVtA0Yv5o56eta2Uweruyk/ThatGreenSpace/KSAOS/cctray.xml'

class Build

  def initialize(url)
    @url = url
  end

  def sleeping?
    stages_activities.reject { |a| a == "Sleeping" }.empty?
  end

  def failing?
    stages_statuses.include? "Failure"
  end

  def buidling?
    stages_activities.include? "Building"
  end

  private

  def doc
    @doc ||= Nokogiri.XML(fetch_data)
  end

  def fetch_data
    # Net::HTTP.get_response(URI.parse(@url)).body
    open(@url).read
  end

  def stages_statuses
    @stages_statuses ||= doc.css('Project').map { |project| project['lastBuildStatus'] }
  end

  def stages_activities
    @stages_activities ||= doc.css('Project').map { |project| project['activity'] }
  end

end

begin
  build = Build.new url
  if build.failing?
    system 'usblamp red'
  elsif build.buidling?
    system 'usblamp blue'
  end

  sleep 4
  system 'usblamp off'
  sleep 1
end while true
