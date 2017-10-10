# encoding: utf-8
# frozen_string_literal: true

json.id user_ship.id
json.name user_ship.name
json.purchased user_ship.purchased
json.sale_notify user_ship.sale_notify
json.ship do
  json.partial! 'api/v1/ships/minimal', ship: user_ship.ship
end
json.user do
  json.partial! 'api/v1/users/base', user: user_ship.user
end
json.partial! 'api/shared/dates', record: user_ship