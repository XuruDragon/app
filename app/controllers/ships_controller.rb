class ShipsController < ApplicationController
  before_action :set_active_nav
  before_filter :authenticate_user!, only: [:reload]

  def index
    authorize! :index, :ships
    @ships = find_ships
    @ships = @ships
      .order("ships.name asc")
      .page(params.fetch(:page, nil))
      .per(8)
    respond_to do |format|
      format.js {
        render json: @ships
      }
      format.html {
        # render index
      }
    end
  end

  def show
    authorize! :show, ship
    if ship.nil?
      redirect_to ships_path, alert: I18n.t(:"messages.record_not_found")
    end
  end

  def gallery
    authorize! :gallery, ship
    @images = ship.images.enabled
      .order("created_at asc ")
      .page(params.fetch(:page){nil})
      .per(24)
  end

  private def set_active_nav
    @active_nav = 'ships'
  end

  private def ship
    @ship ||= Ship.where(slug: params.fetch(:slug, nil)).first
  end
  helper_method :ship

  private def find_ships
    ships = Ship.enabled.includes(:ship_role, :manufacturer)
    ship_role = params.fetch(:ship_role, nil)
    manufacturer = params.fetch(:manufacturer, nil)
    search = params.fetch(:search, nil)

    if ship_role.present?
      ships = ships.where("ship_roles.slug = ?", ship_role).references(:ship_role)
    end

    if manufacturer.present?
      ships = ships.where("manufacturers.slug = ?", manufacturer).references(:manufacturer)
    end

    if search.present?
      search_conditions = []
      search_conditions << "lower(ships.name) like :search"
      search_conditions << "lower(ships.description) like :search"
      ships = ships.where([
        search_conditions.join(' OR '),
        { search: "%#{search.downcase}%" }
      ])
    end

    ships
  end
end