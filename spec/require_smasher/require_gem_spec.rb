require "spec_helper"

RSpec.describe RequireGem do
  subject { RequireGem.req(gems) }

  context '#req' do
    context 'when gem is not informed' do
      let(:gems) { [] }
      
      it 'raise StandardError' do
        expect{ subject }.to raise_error(StandardError, 'Gem was not informed')
      end
    end

    context 'when gem is not installed' do
      let(:gems) { ['gem'] }

      it 'raise LoadError' do
        expect{ subject }.to raise_error(LoadError, "cannot load such file -- #{gems.first}")
      end
    end

    context 'when another error raises' do
      let(:gems) { [['gem']] }

      it 'raise StandardError' do
        expect{ subject }.to raise_error(StandardError)
      end
    end

    context 'when a gem was informed correctly' do
      let(:gems) { ['rspec'] }

      it 'return a list of required gems' do
        expect(subject).to eq ['rspec']
      end
    end

    context 'when a list of gems were informed correctly' do
      let(:gems) { ['rspec', 'rake'] }

      it 'return a list of required gems' do
        expect(subject).to eq ['rspec', 'rake']
      end
    end
  end
end
