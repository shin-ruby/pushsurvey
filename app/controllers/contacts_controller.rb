class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.xml
  def index
    @contacts = Contact.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        format.html { redirect_to(@contact, :notice => 'Contact was successfully created.') }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to(@contact, :notice => 'Contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end

  def import
    puts "importing"
    if ENV['SENDGRID_USERNAME'] #in heroku environment
    via_options = {
        :address => 'smtp.sendgrid.net',
        :port => '25',
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain => ENV['SENDGRID_DOMAIN'] # the HELO domain provided by the client to the server
    }
    else
         via_options = {
        :address => 'smtp.sendgrid.net',
        :port => '25',
        :user_name => 'app635634@heroku.com',
        :password => "f92de9dc1d4b4b18b5",
        :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain => "heroku.com" # the HELO domain provided by the client to the server
    }

    end
    #Pony.mail(:to => 'femtowin@gmail.com', :from => 'admin@proedm.com', :subject => 'hi', :body => 'Hello there.<a href=http://www.google.com>google</a>',
    # :via => :smtp, :via_options => via_options)

  end
  def do_import

    require 'fileutils'

    filename = params[:xx].path + File.extname(params[:xx].original_filename)
    FileUtils.cp  params[:xx].path, filename

    Importer.do_import( filename)


    redirect_to contacts_path
  end
end
