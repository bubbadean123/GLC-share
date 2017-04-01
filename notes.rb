Shoes.app(:title => "Notes") do
  @notes=stack do
  end
  stack do
    @title=edit_line
    @body=edit_box
    button("Save").click do
      i=0
      fe=nil
      @notes.contents.each do |stack|
        if stack.contents[0].text==@title.text
          fe=stack
          break
        end
        i+=1
      end
      if fe
         fe.contents[1].text=@body.text
      else
        @notes.prepend {
          stack do
            para @title.text
            para @body.text
            para link("Delete") { |this| this.parent.parent.remove}
          end
        }
      end
    end
  end
end
