# frozen_string_literal: true

RSpec.describe OSS::Config do
  subject(:config) { OSS.config }

  before do
    OSS.config.reset
  end

  context '#defaults' do
    it 'includes loader' do
      expect(config.loader).to be_a OSS::Loader::Default
    end
  end
end
