module Tsc
  module Conf
    mod_list = JSON.parse(File.read(File.join(File.expand_path(__dir__), 'channel_and_mod_list.json')))
    mod_list.each_key do |channel|
      mod_list[channel] = mod_list[channel].to_set
    end
    MODS = mod_list
  end
end
