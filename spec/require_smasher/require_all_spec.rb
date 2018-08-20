require "spec_helper"

RSpec.describe RequireAll do
  context '#req' do
    subject { RequireAll.req(required_list) }

    context 'when required list is invalid' do
      context 'when files are invalid' do
        let(:required_list) { ['rspec', 'rake', 'invalid_file1', 'invalid_file2'] }

        it 'raise LoadError' do
          expect{ subject }.to raise_error(LoadError, 'cannot load such file -- invalid_file1')
        end
      end

      context 'when gems are invalid' do
        let(:required_list) { ['rspec', 'rake', 'invalid_gem_1', 'invalid_gem_2'] }

        it 'raise LoadError' do
          expect{ subject }.to raise_error(LoadError, 'cannot load such file -- invalid_gem_1')
        end
      end

      context 'when directories are invalid' do
        let(:required_list) { ['rspec', 'invalid_directory/invalid_subdirectory'] }

        it 'raise LoadError' do
          expect{ subject }.to raise_error(LoadError, 'cannot load such file -- invalid_directory/invalid_subdirectory')
        end
      end
    end

    context 'when required list is valid' do
      let(:required_list) do
        [
          'rspec',
          'rake',
          'spec/fixtures/dependents',
          'spec/fixtures/with_cross_dependences',
          'spec/fixtures/independents/u',
          'spec/fixtures/independents/v.rb'
        ]
      end

      it 'return nil' do
        expect(subject).to be_nil
      end
    end
  end
end
