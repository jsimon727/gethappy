def destroy
  @bars = user.bars
  @bar = @bars.find_by(id: params[:bar_id])
  @bar.delete
end