describe '#login' do
  subject { post :login }
  context '正しいパスワードの場合' do
    it '正常に認証される' do
      expect(@user.authenticate("popo")).to be_truthy
    end
  end
end