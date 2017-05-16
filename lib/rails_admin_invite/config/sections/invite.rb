# frozen_string_literal: true
require 'rails_admin/config/sections/create'

module RailsAdmin
  module Config
    module Sections
      class Invite < RailsAdmin::Config::Sections::Create
        register_instance_option :before_save do
          nil
        end

        register_instance_option :after_save do
          nil
        end
      end
    end
  end
end
