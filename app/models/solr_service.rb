class SolrService
  @@connection = false

  def self.connect
    @@connection = RSolr.connect(url: "http://localhost:8983/solr/ebay_like")
    @@connection
  end

  def self.add(params)
    connect unless @@connection
    @@connection.add(params)
  end

  def self.commit
    connect unless @@connection
    @@connection.commit
  end

  def self.delete_by_id(id)
    connect unless @@connection
    @@connection.delete_by_id(id)
  end
end
