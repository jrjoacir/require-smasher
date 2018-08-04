require "spec_helper"

RSpec.describe RequireGem do
  subject { RequireGem.req(gem) }

  context '#req' do
    context 'when gem is not informed' do
      let(:gem) { nil }
      
      it 'raise StandardError' do
        expect{ subject }.to raise_error(StandardError, 'Gem was not informed')
      end
    end

    context 'when gem is not installed' do
      let(:gem) { 'gem' }

      it 'raise LoadError' do
        expect{ subject }.to raise_error(LoadError, "Error requering gem '#{gem}': cannot load such file -- #{gem}")
      end
    end

    context 'when another error raises' do
      let(:gem) { ['gem'] }

      it 'raise Standard' do
        expect{ subject }.to raise_error(StandardError, "Error requering gem '#{gem}': no implicit conversion of Array into String")
      end
    end
  end
end
