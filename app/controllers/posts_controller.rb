class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :good]
  respond_to :json
  require 'json'
  before_action :set_default_response_format

  # GET /posts
  # GET /posts.json
  def index
    headers['Content-Type'] = "application/json; charset=UTF-8"
    params[:my_latitude] = 35.690224
    params[:my_longitude] = 159.700089
    my_spot = User.where(authentication_token: "dXqVRHCGx7hyC_7i1kxE").new(my_latitude: params[:my_latitude].to_f, my_longitude: params[:my_longitude].to_f)

    @postsall = Post.all
    # @posts = Post.all
    @posts = @postsall.by_distance(origin: my_spot).limit(3)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # @comment = Post.find(params[:id]).comments.build
  end

  def good
    @post = Post.find(params[:id])
    @post.good = @post.good + 1
    @post.save
    render :nothing => true
  end

  def bad
    @post = Post.find(params[:id])
    @post.bad = @post.bad + -1
    @post.save
    render :nothing => true
  end

  # GET /posts/new
  def new
    # headers['Content-Type'] = "application/json; charset=UTF-8"
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    headers['Content-Type'] = "application/json; charset=UTF-8"
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: request.request_method }
        format.json { render :json => @post.to_json(:include => [:comments]) }
        print 'request_method: '
        puts request.request_method
        print 'request_method_symbol: '
        puts request.request_method_symbol
        print 'method: '
        puts request.method
        print 'patch: '
        puts request.patch?
        print 'head: '
        puts request.head?
        print 'headers: '
        puts request.headers
        print 'original_fullpath: '
        puts request.original_fullpath
        print 'fullpath: '
        puts request.fullpath
        print 'original_url: '
        puts request.original_url
        print 'media_type: '
        puts request.media_type
        print 'content_length: '
        puts request.content_length
        print 'ip: '
        puts request.ip
        print 'remote_ip: '
        puts request.remote_ip
        print 'uuid: '
        puts request.uuid
        print 'raw_post: '
        puts request.raw_post
        print 'body: '
        puts request.body
        print 'form_data: '
        puts request.form_data?
        print 'body_stream: '
        puts request.body_stream
        print 'local: '
        puts request.local?
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  protected

  def set_default_response_format
    request.format = :json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :latitude, :longitude, :good, :bad)
    end

end
