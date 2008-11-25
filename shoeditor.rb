Shoes.app :title => 'Shoe_ditor v. 0.0.1', :width => 800, :height => 600 do
	
	# the submenu is opened?
	@opened = false
	@num = 1
	@editor = 'scite'

	flow do
		@menu_stack = stack :margin => 5, :width => 150 do
			background orange, :curve => 20
			@menu = para link('File',
				:click => proc do
					if !@opened
						create_submenu
					else
						clear_menu_sub
						@opened = !@opened
					end
				end
			), :left => 20
		end
		flow do
			@files_stack = stack :margin => 5, :width => 250, :height => 400, :scroll => true do
				background orange, :curve => 20
			end
			@bleah = stack :margin => 5, :width => -350, :top => -40  do
				@open_editor = para :width => 350
				@box = edit_box( :width => 540, :height => 400)
			end
		end
	end
	def open_file
		file = ask_open_file
		@box.text = File.read(file)
		open_in_editor(file)
		@opened = !@opened
	end
	def open_dir
		Dir[File.dirname(__FILE__) + '/*'].each_with_index do |file, i|
			@files_stack.append do
				para( i + @num, ' - ', link(file.gsub('./', '') ){@box.text =  File.read(file); open_in_editor(file)}, " - ",
				link('delete'){|x| x.parent.remove})
			end
			
		end
		@opened = !@opened
	end
	def clear_menu_sub
		@f.clear
	end
	def create_submenu
		@f = flow:width=>200, :height=>150, :top=>5, :left=>45 do
			fill rgb(250,250,100)
			rect 0,0,180,90, 20
			
			inscription ">> ", link("Open a file"){open_file; clear_menu_sub},
				"\n",
				">> ", link("Open current dir"){open_dir; clear_menu_sub},
				"\n",
				#">> ", link("Open a specific dir - not implemented yet"){open_dir; clear_menu_sub}
				">> ", ("Open a specific dir\n- not implemented yet")
		end
		@opened = !@opened
	end
	def open_in_editor(file)
		@open_editor.text = link('open in editor'){system "#@editor #{file}"}
	end
	def paginate
		
	end
end