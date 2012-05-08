# -*- encoding : utf-8 -*-
class AddEmailSubjectToPush < ActiveRecord::Migration
  def self.up
    add_column :pushes, :subject, :string
    add_column :pushes, :signature, :text
    add_column :pushes, :from_email, :string
    add_column :pushes, :reply_to_email, :string
  end

  def self.down
    remove_column :pushes, :reply_to_email
    remove_column :pushes, :from_email
    remove_column :pushes, :signature
    remove_column :pushes, :subject
  end
end
