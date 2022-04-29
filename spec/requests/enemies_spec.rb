require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  describe "PUT /update" do
    context "when the enemy exists" do
      let(:enemy) { create(:enemy) }
      let(:enemy_attributes) { attributes_for(:enemy) }
      
      before(:each) { put "/enemies/#{enemy.id}", params: enemy_attributes }

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "updates the enemy" do
        expect(enemy.reload).to have_attributes(enemy_attributes)
      end

      it "returns the enemy updated" do
        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))
      end
    end
    
    context "when the enemy does not exist" do
      before(:each) { put "/enemies/0", params: attributes_for(:enemy) }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe "DELETE /destroy" do
    context "when the enemy exists" do
      let(:enemy) { create(:enemy) }
      before(:each) { delete "/enemies/#{enemy.id}" }

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
      
      it "destroy the record" do
        expect{ enemy.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end
    
    context "when the enemy does not exist" do
      before(:each) { delete "/enemies/0" }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe "GET /index" do
    it "returns status code 200" do
      get enemies_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    context "when the enemy exists" do
      let(:enemy) { create(:enemy) }
      before(:each) { get "/enemies/#{enemy.id}" }

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the enemy does not exist" do
      it "returns status code 404" do
        get "/enemies/0"
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST /create" do # método que permite a criação de novos inimigos e retorna via json os dados do inimigo criado
    context "when it has valid parameters" do
      let(:enemy) { create(:enemy) }
      let(:enemy_attributes) { attributes_for(:enemy) }
      before(:each) { post "/enemies/", params: enemy_attributes }

      it "create the enemy with correct attributes" do
        expect(response).to have_http_status(201)
      end
    end

    context "when it has no valid parameters" do
      it "does not create enemy" do
        expect{
          post enemies_path, params: { enemy: { name: 'IsThisSparta?', power_base: 1000, power_step: 100, level: '', kind: '' } }
        }.to_not change(Enemy, :count)
      end
    end
  end
end
