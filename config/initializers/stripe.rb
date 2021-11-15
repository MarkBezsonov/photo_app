Rails.configuration.stripe = {
  :publishable_key => Figaro.env.stripe_test_publishable_key,
  :secret_key      => Figaro.env.stripe_test_secret_key
}

Stripe.api_key = Figaro.env.stripe_test_secret_key