module ObjStore
  def self.set(key, value)
    @objs ||= {}
    @objs[key] = value
  end
  
  def self.get(key)
    @objs ||= {}
    @objs[key]
  end
end