# encoding: utf-8
# frozen_string_literal: true

json.cache! ['v1', ship] do
  json.partial! 'api/v1/ships/base', ship: ship
  json.manufacturer do
    json.partial! 'api/v1/ships/manufacturer', manufacturer: ship.manufacturer if ship.manufacturer.present?
  end
  json.ship_role do
    json.partial! 'api/v1/ships/ship_role', ship_role: ship.ship_role if ship.ship_role.present?
  end
  json.partial! 'api/shared/dates', record: ship
end