Admin.controllers :sites do

  get :index do
    @sites = Site.all
    render 'sites/index'
  end

  get :new do
    @site = Site.new
    render 'sites/new'
  end

  post :create do
    @site = Site.new(params[:site])
    if @site.save
      flash[:notice] = 'Site was successfully created.'
      redirect url(:sites, :edit, :id => @site.id)
    else
      render 'sites/new'
    end
  end

  get :edit, :with => :id do
    @site = Site.find(params[:id])
    render 'sites/edit'
  end

  put :update, :with => :id do
    @site = Site.find(params[:id])
    if @site.update_attributes(params[:site])
      flash[:notice] = 'Site was successfully updated.'
      redirect url(:sites, :edit, :id => @site.id)
    else
      render 'sites/edit'
    end
  end

  delete :destroy, :with => :id do
    site = Site.find(params[:id])
    if site.destroy
      flash[:notice] = 'Site was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Site!'
    end
    redirect url(:sites, :index)
  end
end