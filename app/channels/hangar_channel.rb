# encoding: utf-8
# frozen_string_literal: true

class HangarChannel < ApplicationCable::Channel
  def subscribed
    stream_from "hangar_#{params[:action]}_#{params[:username]}"
  end
end