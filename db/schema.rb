# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_170_328_221_922) do
  create_table 'calls', force: :cascade do |t|
    t.string 'bioguide_id'
    t.string 'comments'
    t.boolean 'got_through', default: false
    t.boolean 'busy', default: false
    t.boolean 'voice_mail', default: false
    t.boolean 'mailbox_full', default: false
    t.integer 'rating'
    t.integer 'user_id'
    t.integer 'office_location_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'office_locations', force: :cascade do |t|
    t.string 'bioguide_id'
    t.string 'locality'
    t.string 'region'
    t.string 'postal_code'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'phone'
    t.string 'office_type'
    t.boolean 'active', default: true
    t.string 'office_id'
  end

  create_table 'reps', force: :cascade do |t|
    t.string 'bioguide_id'
    t.string 'official_full'
    t.string 'family_name'
    t.string 'given_name'
    t.string 'additional_name'
    t.string 'honorific_prefix'
    t.string 'honorific_suffix'
    t.string 'party_identification'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'state'
    t.string 'vcard'
    t.string 'photo'
    t.string 'district'
    t.string 'url'
    t.string 'twitter'
    t.string 'youtube'
    t.string 'facebook'
    t.string 'instagram'
    t.boolean 'active', default: true
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'slug'
  end
end
