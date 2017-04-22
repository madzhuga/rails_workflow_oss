# frozen_string_literal: true

RSpec.describe OSS::Config do
  subject(:config) { OSS.config.reset }

  context '#defaults' do
    it 'includes loader' do
      expect(config.loader).to be_a OSS::Loader::Default
    end
  end

  context '#reset' do
    before do
      OSS.setup do |config|
        config.builder_class = 'SomeBuilderClass'
      end
    end
    it 'resets all configuration' do
      OSS.config.reset
      expect(config.builder_class).not_to eq 'SomeBuilderClass'
    end
  end
end
