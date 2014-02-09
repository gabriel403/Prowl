module Remoteserver

  class DeployHooks

    class << self

      require 'net/http'
      include Rails.application.routes.url_helpers

      def send_update(hooks, deploy, status)
        if !hooks
          return false
        end
        hooks.each do |hook|
          if !hook.additional.has_key?("url")
            next
          end

          url          = hook.additional['url']
          payload_name = "text"

          if hook.additional.has_key?("payload_name")
            payload_name = hook.additional['payload_name']
          end

          case status
          when :pending
            message = "Deployment <#{deploy_url(deploy)}|#{deploy.id}> for <#{app_url(deploy.app)}|#{deploy.app.name}> has been triggered by #{deploy.user.email.split('@')[0].titleize}"
          when :processing
            message = "Deployment <#{deploy_url(deploy)}|#{deploy.id}> for <#{app_url(deploy.app)}|#{deploy.app.name}> has been pick up from the queue and is processing"
          when :finished
            message = "Deployment <#{deploy_url(deploy)}|#{deploy.id}> for <#{app_url(deploy.app)}|#{deploy.app.name}> has finished successfully"
          when :failed
            message = "Deployment <#{deploy_url(deploy)}|#{deploy.id}> for <#{app_url(deploy.app)}|#{deploy.app.name}> has failed"
          else
            return false
          end

          params = {payload_name => message}
          uri    = URI(url)
          Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            request      = Net::HTTP::Post.new uri
            request.body = JSON.generate(params)
            response     = http.request request # Net::HTTPResponse object
            if response.instance_of?(Net::HTTPInternalServerError)
              Rails.logger.fatal response
              Rails.logger.fatal response.body
            end
            Rails.logger.info response
          end
        end
      end

    end
  end
end