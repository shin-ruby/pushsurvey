class DesignsController < InheritedResources::Base
  def index
    @designs = Design.with_user
  end

  def save
    @design = Design.find(params[:id])
    if current_user.can_view(@design)
      #headers['Content-Type'] = "application/octet-stream" # I've also seen this for CSV files: 'text/csv; charset=iso-8859-1; header=present'
      #headers['Content-Disposition'] = "attachment; filename=\"#{@design.name}.html\""
      #send_data @design.html
      send_data @design.html, :type => "application/octet-stream",:filename => "#{@design.name}.html"
    else
      redirect_to designs_path, :notice=> "You don't have permissions for saving this design"
      #flash[:notice] = "You don't have permissions for previewing this design"
      #index
      #render :index
    end
  end

  def preview
    @design = Design.find(params[:id])
    if current_user.can_view(@design)
      render :text => @design.html.html_safe
    else
      redirect_to designs_path, :notice=> "You don't have permissions for previewing this design"
      #flash[:notice] = "You don't have permissions for previewing this design"
      #index
      #render :index
    end
  end
end
