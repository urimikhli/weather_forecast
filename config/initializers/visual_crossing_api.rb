Rails.application.config.to_prepare do
  # Put any code here that sets up non-reloaded VisualCrossingApi code with
  # objects from elsewhere that may be reloaded.
  #
  # Runs once at startup time in production, and whenever code is reloaded
  # (once a request) in development.
  #
  # Example:
  VisualCrossingApi.configure(
    base_url: CONFIG.with_indifferent_access[:visual_crossing_api_url],
    api_key: CONFIG.with_indifferent_access[:visual_crossing_key],
  )
end
