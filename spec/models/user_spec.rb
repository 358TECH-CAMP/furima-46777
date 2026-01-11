# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      user = User.new(
        nickname: '',
        email: 'test@example.com',
        password: '000000',
        password_confirmation: '000000'
      )
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      user = User.new(
        nickname: 'test',
        email: '',
        password: '000000',
        password_confirmation: '000000'
      )
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'birth_dateが空では登録できない' do
      user = User.new(
        nickname: 'test',
        email: 'test@example.com',
        password: '000000',
        password_confirmation: '000000',
        birth_date: ''
      )
      user.valid?
      expect(user.errors.full_messages).to include("Birth date can't be blank")
    end

    it 'first_nameとlast_nameが空では登録できない' do
      user = User.new(
        nickname: 'test',
        email: 'test@example.com',
        password: '000000',
        password_confirmation: '000000',
        first_name: '',
        last_name: '',
        first_name_kana: 'テスト',
        last_name_kana: 'ユーザー',
        birth_date: '2000-01-01'
      )
      user.valid?
      expect(user.errors.full_messages).to include(
        "First name can't be blank",
        "Last name can't be blank"
      )
    end

    it 'first_name_kanaとlast_name_kanaが空では登録できない' do
      user = User.new(
        nickname: 'test',
        email: 'test@example.com',
        password: '000000',
        password_confirmation: '000000',
        first_name: '太郎',
        last_name: '山田',
        first_name_kana: '',
        last_name_kana: '',
        birth_date: '2000-01-01'
      )
      user.valid?
      expect(user.errors.full_messages).to include(
        "First name kana can't be blank",
        "Last name kana can't be blank"
      )
    end
  end
end
