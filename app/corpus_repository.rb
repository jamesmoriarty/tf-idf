class CorpusRepository
  class << self
    def all
      storage.to_a
    end

    def find(id)
      storage[id]
    end

    def save(entity)
      storage << entity unless storage.include?(entity)
      storage.index(entity)
    end

    def destroy(id)
      storage[id] = nil
    end

    private

    def storage
      @storage ||= [nil]
    end
  end
end
