
class Armstrong

  private

  def self.boilerplate line, regex

    match = line.match regex

    return unless match

    return regex.source.scan(/\?\<([a-zA-Z0-9_]+)\>/).flatten

  end

  def self.snake_casify(string)
    string
      .gsub(/::/, '/')
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr('-', '_')
      .downcase
  end

  public

  def self.given line, regex, call:

    capture_groups = boilerplate line, regex

    if capture_groups.empty?
      send(call)
    else
      send(call, *capture_groups.map { |name| match[name.to_sym] })
    end
  end

  def self.package line, regex, for:

    call = binding.local_variable_get(:for)

    capture_groups = boilerplate line, regex

    match = line.match(regex)

    if capture_groups.empty?
      unless method(call).arity == 0
        fail <<~END
        The function given -- #{call} -- requires some amount of arguments.
        Armstrong wanted to pass zero arguments to it because no capture groups were found in your regex:
        #{regex}
        
        If you wish to call this function without the implicit capture group stuff, use Armstrong.on instead.

        END
      end
      send(call)
    else
      token = {}
      capture_groups.each do |group|
        key = snake_casify group
        token.store(key, match[group.to_sym])
      end

      send(call, token)
    end
  end

  def self.on line, matching:, do:
    call = binding.local_variable_get(:do)
    regex = binding.local_variable_get(:matching)
    
    return unless line =~ regex

    send(call)
  end
end



