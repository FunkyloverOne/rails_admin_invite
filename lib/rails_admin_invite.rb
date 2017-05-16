# frozen_string_literal: true
require 'rails_admin_invite/engine'
require 'rails_admin_invite/config/sections/invite'
require 'rails_admin/config/actions'

module RailsAdminInvite; end

module RailsAdmin
  module Config
    module Actions
      class Invite < Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection do
          true
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :controller do
          proc do
            if request.get?
              @object = @abstract_model.new
              @authorization_adapter && @authorization_adapter.attributes_for(
                :invite, @abstract_model
              ).each do |name, value|
                @object.send("#{name}=", value)
              end
              if (object_params = params[@abstract_model.param_key])
                sanitize_params_for!(:invite)
                @object.set_attributes(
                  @object.attributes.merge(object_params.to_h)
                )
              end
              respond_to do |format|
                format.html { render @action.template_name }
                format.js   { render @action.template_name, layout: false }
              end

            elsif request.post?
              # TODO: find out what is @modified_assoc
              # @modified_assoc = []
              @object = @abstract_model.new
              sanitize_params_for!(:invite)

              @object.set_attributes(params[@abstract_model.param_key])
              @authorization_adapter && @authorization_adapter.attributes_for(
                :invite, @abstract_model
              ).each do |name, value|
                @object.send("#{name}=", value)
              end

              @abstract_model.config.invite.before_save(@object)

              if @object.save
                # TODO: find out more about @auditing_adapter
                # @auditing_adapter && @auditing_adapter.create_object(
                #   @object, @abstract_model, _current_user
                # )
                @abstract_model.config.invite.after_save(@object)
                respond_to do |format|
                  format.html { redirect_to_on_success }
                  format.js do
                    render json: {
                      id: @object.id.to_s,
                      label: @model_config.with(object: @object).object_label
                    }
                  end
                end
              else
                handle_save_error(:invite)
              end

            end
          end
        end

        register_instance_option :link_icon do
          'fa fa-users'
        end
      end
    end
  end
end
