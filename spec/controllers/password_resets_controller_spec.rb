require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    context 'with a valid user and email' do
      let(:user) { create(:user) }

      it 'finds the user' do
        expect(User).to receive(:find_by).with(email: user.email).and_return(user)
        post :create, params: { email: user.email }
      end

      it 'generates a new password token' do
        expect do
          post :create, params: { email: user.email }
          user.reload
        end.to change { user.password_reset_token }
      end

      it 'sends a password reset email' do
        expect { post :create, params: { email: user.email } }.to change(ActionMailer::Base.deliveries, :size)
      end

      it 'sets the flash[:success] message' do
        post :create, params: { email: user.email }
        expect(flash[:success]).to match(/check your email./)
      end
    end

    context 'with no user found' do
      before { post :create, params: { email: 'none@found.com' } }

      it 'renders the new page' do
        expect(response).to render_template('new')
      end

      it 'sets the flash[:notice] message' do
        expect(flash[:notice]).to match(/not found./)
      end
    end
  end

  describe 'GET edit' do
    context 'with a valid email' do
      let(:user) { create(:user) }
      before do
        user.generate_password_reset_token!

        get :edit, params: { id: user.password_reset_token }
      end

      it 'renders the edit template' do
        expect(response).to render_template('edit')
      end

      it 'assigns a @user' do
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'with no password_reset_token found ' do
      it 'renders the 404 page' do
        get :edit, params: { id: 'notfound' }
        expect(response.status).to eq(404)
        expect(response).to render_template(file: "#{Rails.root}/public/404.html")
      end
    end
  end

  describe 'PATCH update' do
    context 'with no token found' do
      before do
        patch :update, params: {
          id: 'notfound',
          user: { password: 'newpassword', password_confirmation: 'newpassword' }
        }
      end

      it 'renders the edit page' do
        expect(response).to render_template('edit')
      end

      it 'sets the flash[:notice] message' do
        expect(flash[:notice]).to match(/not found./)
      end
    end

    context 'with a valid token' do
      let(:user) { create(:user) }
      before do
        user.generate_password_reset_token!

        patch :update, params: {
          id: user.password_reset_token,
          user: { password: 'newpassword', password_confirmation: 'newpassword' }
        }
      end

      it 'updates the users password' do
        digest = user.password_digest
        user.reload
        expect(user.password_digest).to_not eq(digest)
      end

      it 'clears the password_reset_token' do
        user.reload
        expect(user.password_reset_token).to be_blank
      end

      it "sets the session[:user_id] to the user's id" do
        expect(session[:user_id]).to eq(user.id)
      end

      it 'sets the flash[:success] message' do
        expect(flash[:success]).to match(/password updated/i)
      end

      it 'redirects to the todo_lists page' do
        expect(response).to redirect_to(todo_lists_path)
      end
    end
  end
end
