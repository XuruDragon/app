# encoding: utf-8
# frozen_string_literal: true

require 'rsi_orgs_loader'

module Api
  module V1
    module Rsi
      class OrgsController < ::Api::V1::BaseController
        skip_authorization_check
        before_action :authenticate_api_user!, only: %i[]
        before_action :check_org, only: %i[show ships]
        after_action only: [:index] { pagination_header(:orgs) }
        after_action only: [:ships] { pagination_header(:user_ships) }

        def index
          @q = RsiOrg.ransack(query_params)
          @orgs = @q.result
                    .order(name: :asc)
                    .page(params[:page])
                    .per(per_page)
        end

        def show
          @org = org
        end

        def ships
          @q = UserShip.includes(:user)
                       .where("users.rsi_org = ?", params[:sid])
                       .references(:user)
                       .purchased
                       .ransack(query_params)
          @user_ships = @q.result
                          .includes(:ship)
                          .order("ships.name asc")
                          .page(params[:page])
                          .per(per_page)
        end

        private def check_org
          return if org.present?

          render json: { code: 'rsi.org.not_found', message: 'Could not find Organization' }, status: :not_found
        end

        private def org
          @org ||= RsiOrg.find_by(sid: params[:sid].downcase)
          @org ||= RsiOrgsLoader.new.fetch(params[:sid].downcase)
        end
      end
    end
  end
end