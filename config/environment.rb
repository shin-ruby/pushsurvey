# -*- encoding : utf-8 -*-
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ENV["ROO_TMP"] = "tmp"
Proedm::Application.initialize!
