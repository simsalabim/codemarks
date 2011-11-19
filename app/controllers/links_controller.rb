class LinksController < ApplicationController

  require 'link_saver'
  def new
    @link = Link.new
    if params[:url]
      @link.url = params[:url]
      @link.fetch_title
      @possible_topics = @link.possible_topics
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    params[:link][:user_id] = current_user_id if logged_in?
    @link = ResourceManager::LinkSaver.create_new_link params
    if @link
      redirect_to @link.topics.first, :notice => "Link created"
    else
      render :new
    end
  end

  def show
    @link = Link.find params[:id]
  end

  def click
    link = Link.find(params[:link][:id])
    puts Click.create(:link => link, :user => current_user).inspect
    link_js =  "window.open(\'#{link.url}\', '_blank', 'toolbar=0,location=0,menubar=0');"
    puts link_js.inspect
    render :js => link_js
  end

end
