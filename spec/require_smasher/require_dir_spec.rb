require "spec_helper"

RSpec.describe RequireDir do
  subject { RequireDir.req(directories) }

  context '#req' do
    context 'when directory is not informed' do
      let(:directories) { [] }
      
      it 'raise StandardError' do
        expect{ subject }.to raise_error(StandardError, 'Directory was not informed')
      end
    end

    context 'when directory does not exist' do
      let(:directories) { ['dir'] }
      
      it 'raise error StandardError with message' do
        expect{ subject }.to raise_error(StandardError, "Directory '#{directories.first}' does not exist")
      end
    end

    context 'when directory does not have sub-directories' do
      context 'when require dependencies are not solved' do
        let(:directories) { ['spec/fixtures/without_subdirectories/with_errors'] }

        it 'raise error StandardError with message' do
          expect{ subject }.to raise_error(StandardError, /uninitialized constant/)
          expect{ subject }.to raise_error(StandardError, /Error while requiring file/)
        end
      end

      context 'when require dependencies are solved' do
        let(:directories) { ['spec/fixtures/without_subdirectories/without_errors'] }

        it 'return nil' do
          expect(subject).to be_nil
        end
      end
    end

    context 'when directory has sub-directories' do
      context 'when require dependencies are not solved' do
        let(:directories) { ['spec/fixtures/with_subdirectories/with_errors'] }

        it 'raise error StandardError with message' do
          expect{ subject }.to raise_error(StandardError, /uninitialized constant/)
          expect{ subject }.to raise_error(StandardError, /Error while requiring file/)
        end
      end

      context 'when require dependencies are solved' do
        let(:directories) { ['spec/fixtures/with_subdirectories/without_errors'] }

        it 'return nil' do
          expect(subject).to be_nil
        end
      end
    end
  end
end
