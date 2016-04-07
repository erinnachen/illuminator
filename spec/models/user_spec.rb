require 'spec_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :uid }
  it { should validate_uniqueness_of :uid }
  it { should validate_presence_of :name }
  it { should validate_presence_of :nickname }
  it { should validate_presence_of :avatar }
  it { should validate_presence_of :oauth_token }
end
