class Presenter < ApplicationRecord
  self.abstract_class = true

  def self.hash_to_objects(hash)
    json = JSON.parse(hash).deep_symbolize_keys
    objects = self.parse_included(json[:included])
    temp = []

    case json[:data]
    when Array
      json[:data].each do |hash|
        temp << self.create_object(hash)
      end
    else
      temp << self.create_object(json[:data])
    end
    if objects[json[:data][:type]].blank?
      objects[json[:data][:type]] = temp
    else
      temp.each do |x|
        objects[json[:data][:type]] << x
      end
    end
    objects.each do |type, array|
      array.each do |obj|
        self.link_associations(obj, objects)
      end
    end
    return objects[json[:data][:type]]
  end

  def self.link_associations(object, collection)
    collection.each do |type, array|
      if object.respond_to? type
        array.each do |asc|
          if object.send(type).first[:id] == asc.id
            object.send("#{type}=", asc)
          end
        end
      elsif object.respond_to? type.to_s.pluralize.to_sym
        temp = []
        array.each do |asc|
          object.send(type.to_s.pluralize.to_sym).each do |rel|
            if rel[:id] == asc.id
              temp << asc
            end
          end
        end
        object.send("#{type.to_s.pluralize.to_sym}=", temp)
      end
    end
  end

  def self.parse_included(included)
    output = {}
    included.each do |inc|
      if output[inc[:type].to_sym].blank?
        output[inc[:type].to_sym] = [self.create_object(inc)]
      else
        output[inc[:type].to_sym] << self.create_object(inc)
      end
    end
    return output
  end

  def self.create_object(hash)
    attr_list = {}
    hash.each do |k, v|
      case k
      when :attributes
        attr_list.merge! hash[k].except(:files)
        if hash[k][:files]
          attr_list['files'] = []
          hash[k][:files].each do |file|
            attr_list['files'] << self.create_object(file[:data])
          end
        end
      when :relationships
        hash[k].each do |k2, v2|
          case hash[k][k2][:data]
          when Array
            attr_list[k2] ||= []
            hash[k][k2][:data].each do |asc|
              attr_list[k2] << asc
            end
          else
            attr_list[k2] = [hash[k][k2][:data]]
          end
        end
      when :links
        attr_list["links"] = {}
        hash[k].each do |k2, v2|
          attr_list["links"][k2] = v2
        end
      else
        attr_list[k] = v
      end
    end
    return Struct.new(*attr_list.keys).new(*attr_list.values)
  end

end