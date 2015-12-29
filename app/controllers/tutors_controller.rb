class TutorsController < ApplicationController
  # GET /tutors
  # GET /tutors.json
  def index
    @tutors = Tutor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tutors }
    end
  end

  # GET /tutors/1
  # GET /tutors/1.json
  def show
    @tutor = Tutor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tutor }
    end
  end

  # GET /tutors/new
  # GET /tutors/new.json
  def new
    @tutor = Tutor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tutor }
    end
  end

  # GET /tutors/1/edit
  def edit
    @tutor = Tutor.find(params[:id])
  end

  # POST /tutors
  # POST /tutors.json
  def create
    @tutor = Tutor.new(params[:tutor])

    respond_to do |format|
      if @tutor.save
        format.html { redirect_to @tutor, notice: 'Tutor was successfully created.' }
        format.json { render json: @tutor, status: :created, location: @tutor }
      else
        format.html { render action: "new" }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tutors/1
  # PUT /tutors/1.json
  def update
    @tutor = Tutor.find(params[:id])

    respond_to do |format|
      if @tutor.update_attributes(params[:tutor])
        format.html { redirect_to @tutor, notice: 'Tutor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutors/1
  # DELETE /tutors/1.json
  def destroy
    @tutor = Tutor.find(params[:id])
    @tutor.destroy

    respond_to do |format|
      format.html { redirect_to tutors_url }
      format.json { head :no_content }
    end
  end
end
