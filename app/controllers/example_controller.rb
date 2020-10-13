# frozen_string_literal: true

class PostsController < ApplicationController
  permits :title, :text, :approved

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show(id)
    @post = Post.find(id)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit(id)
    @post = Post.find(id)
  end

  # POST /posts
  def create(post)
    @post = Post.new(post)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PUT /posts/1
  def update(id, post)
    @post = Post.find(id)

    if @post.update(post)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy(id)
    @post = Post.find(id)
    @post.destroy

    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end
end
