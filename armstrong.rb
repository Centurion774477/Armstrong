
class Armstrong
  def self.given line, regex, call:

    match = line.match regex

    return unless match

    capture_groups = regex.source.scan(/\?\<([a-zA-Z0-9_]+)\>/).flatten

    if capture_groups.empty?
      send(call)
    else
      send(call, *capture_groups.map { |name| match[name.to_sym] })
    end
  end
end

