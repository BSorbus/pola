# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_pola_session', secure: Rails.env.production?, http_only: true, expire_after: nil

