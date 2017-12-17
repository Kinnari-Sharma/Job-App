Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin,
  "81moyzjd9sf91e",
  "Qjde4cWsEVQn9TZE",
  scope: 'r_basicprofile r_emailaddress',
  fields: ["id", "email-address", "first-name", "last-name"]
end




