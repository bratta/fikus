Fikus.controller do
  get :index do
    render_page('')
  end
  
  get :index, :with => :page_name do
    requested_page = (params[:page_name] == nil) ? '' : params[:page_name]
    render_page(requested_page)
  end
end