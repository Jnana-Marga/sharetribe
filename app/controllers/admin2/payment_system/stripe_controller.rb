module Admin2::PaymentSystem
  class StripeController < Admin2::AdminBaseController

    include Payments

    before_action :ensure_payments_enabled
    before_action :ensure_params_payment_gateway, only: [:enable, :disable]

    def index
      payment_index
    end

    def update_stripe_keys
      process_update_stripe_keys
      render json: { message: t("admin.payment_preferences.stripe_verified") }
    rescue StandardError => e
      render json: { message: e.message }, status: 422
    end

    def common_update
      message = update_payment_preferences

      render json: { message: message }
    rescue StandardError => e
      render json: { message: e.message }, status: 422
    end
  end
end
