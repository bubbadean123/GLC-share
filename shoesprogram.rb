Shoes.app do
  stack do
    @text=edit_line
  end
  para "You typed:"
  @p=para ""
  @text.change do
    @p.text=@text.text
  end  
end
