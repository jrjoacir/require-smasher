require "spec_helper"

RSpec.describe FileSmasher do
  context '#files_by' do
    subject { FileSmasher.files_by(directory) }

    context 'when directory does not exist' do
      let(:directory) { 'dir' }
      it 'raise DirNotExistError' do
        expect{ subject }.to raise_error(DirNotExistError, "Directory '#{directory}' does not exist")
      end
    end

    context 'when directory does not have any file' do
      let(:directory) { 'spec/fixtures/without_files' }

      it 'return a empty list of files' do
        expect(subject).to be_empty
      end
    end

    context 'when directory has files' do
      let(:directory) { 'spec/fixtures/with_subdirectories/without_errors' }

      it 'return a list of files' do
        expect(subject).not_to be_empty
      end
    end
  end

  context '#files' do
    subject { FileSmasher.files(directories) }

    context 'when directory is not informed' do
      let(:directories) { [] }

      it 'raise DirNotInformedError' do
        expect{ subject }.to raise_error(DirNotInformedError, 'Directory was not informed')
      end
    end

    context 'when directory does not exist' do
      let(:directories) { ['inexistent_directory'] }

      it 'raise DirNotExistError' do
        expect{ subject }.to raise_error(DirNotExistError, "Directory '#{directories.first}' does not exist")
      end
    end

    context 'when directories do not have files' do
      let(:directories) { ['spec/fixtures/without_files'] }

      it 'return a empty list of files' do
        expect(subject).to be_empty
      end
    end
    
    context 'when directories have files' do
      let(:directories) do
        [
          'spec/fixtures/with_subdirectories/without_errors',
          'spec/fixtures/without_subdirectories/without_errors'
        ]
      end

      it 'return a list of files' do
        expect(subject).not_to be_empty
      end
    end
  end
end
