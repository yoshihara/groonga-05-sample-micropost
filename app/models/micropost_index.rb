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
