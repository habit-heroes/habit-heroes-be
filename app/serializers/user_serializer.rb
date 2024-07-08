class UserSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :email

  # def serialized_json(user)
  #   {
  #     "data":
  #       {
  #         "id": user.id,
  #         "type": "user",
  #         "attributes": {
  #           "first_name": user.first_name,
  #           "last_name": user.last_name,
  #           "email": user.email
  #         }
  #       }
  #   }
  # end
end