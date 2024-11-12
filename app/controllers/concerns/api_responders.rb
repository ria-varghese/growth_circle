module ApiResponders
  extend ActiveSupport::Concern

  private

    def render_error(message, status = :unprocessable_entity, context = {})
      render file: "public/404.html", status: status, layout: false
    end

    def render_notice(message, status = :ok, context = {})
      render status:, json: { notice: message }.merge(context)
    end

    def render_json(json = {}, status = :ok)
      render status:, json:
    end
end
