class NotesController < ApplicationController

before_action do @person = Person.find(params[:person_id]) end
after_action :only => [:create, :update, :destroy] do person_wertung(@note.person_id) end

def create
  @note=Note.new(note_params)
  @note.person_id=params[:person_id]
  @note.author=http_remote_user
  @note.party_id=@party_active.id
    
	respond_to do |format|
		if @note.save
			flash[:success] = "Note was successfully created by "+http_remote_user
			format.html { redirect_to(@person) }
		else
			flash[:alert] = 'Could not create Note' 
			format.html { redirect_to(@person)}
		end
	end
end

def edit

end

def update
  @note = Note.find(params[:id])
  respond_to do |format|
          if @note.update(note_params)
              flash[:success] = 'Note was successfully updated.'
              format.html  { redirect_to(@person)}
          else
              flash[:alert] = 'Could not update note'
              format.html { redirect_to (@person)}
          end
  end
end

def destroy
  @note = Note.find(params[:id])
	@note.destroy
 
	respond_to do |format|
		format.html { redirect_to(@person) }
	end
  end

private
def note_params
  params.require(:note).permit(:wertung, :text, :author)
end

end
