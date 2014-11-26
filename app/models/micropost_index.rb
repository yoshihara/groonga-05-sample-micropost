class MicropostIndex
  class << self
    def microposts
      Groonga["Microposts"]
    end

    def terms
      Groonga["Terms"]
    end

    def truncate
      microposts.truncate
      terms.truncate
    end

    def search(q)
      return Micropost.all if q.blank?

      Rails.logger.info "Query to Groonga with query: #{q}"

      hit_microposts = microposts.select do |record|
        record.content =~ q
      end

      hit_micropost_ids = hit_microposts.collect do |record|
        record.key.key.to_i
      end

      Micropost.where(id: hit_micropost_ids)
    end

    def refresh_index!
      self.class.truncate
      Micropost.pluck(:id, :content).each do |micropost|
        id, content = micropost
        microposts.add(id.to_s, content: content)
      end
    end

    def update_from(micropost)
      micropost.reload
      return unless micropost.id

      Rails.logger.info "Update Groonga['Microposts'] index micropost.id: #{micropost.id}"

      key = micropost.id.to_s
      microposts.delete(key) if microposts.has_key?(key)
      microposts.add(key, content: micropost.content)
    end
  end
end
