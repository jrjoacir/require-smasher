require "spec_helper"

RSpec.describe FileSmasher do
  context '#files_by' do
    subject { FileSmasher.files_by(directory) }

    context 'when directory does not exist' do
      let(:directory) { 'dir' }
      it 'raise StandardError' do
        expect{ subject }.to raise_error(StandardError, "Directory '#{directory}' does not exist")
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
end
