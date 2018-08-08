require "spec_helper"

RSpec.describe RequireSmasher do
  context '#require_all' do
    subject { require_all(require_1, require_2, require_3, require_4) }

    context 'when required list is invalid' do
      let(:require_1) { 'spec/fixtures/without_subdirectories/without_errors' }
      let(:require_2) { 'rake' }
      let(:require_3) { 'invalid_directory_1' }
      let(:require_4) { 'invalid_gem_1' }

      let(:error_message) { [error_message_1, error_message_2, error_message_3, error_message_4].to_s }
      let(:error_message_1) { "Error requering gem '#{require_3}': cannot load such file -- #{require_3}" }
      let(:error_message_2) { "Directory '#{require_3}' does not exist" }
      let(:error_message_3) { "Error requering gem '#{require_4}': cannot load such file -- #{require_4}" }
      let(:error_message_4) { "Directory '#{require_4}' does not exist" }

      it 'raise a StandardError with message for gems and directories' do
        expect{ subject }.to raise_error(StandardError, error_message)
      end
    end

    context 'when required list is valid' do
      let(:require_1) { 'spec/fixtures/without_subdirectories/without_errors' }
      let(:require_2) { 'rake' }
      let(:require_3) { 'spec/fixtures/with_subdirectories/without_errors' }
      let(:require_4) { 'rspec' }

      it 'return nil' do
        expect(subject).to be_nil
      end
    end
  end

  context '#require_gem' do
    subject { require_gem(gem) }

    context 'when gem is invalid' do
      let(:gem) { 'invalid_gem_1' }
      let(:error_message) { "Error requering gem '#{gem}': cannot load such file -- #{gem}" }

      it 'raise a StandardError with message for a gem' do
        expect{ subject }.to raise_error(StandardError, error_message)
      end
    end

    context 'when gem is valid' do
      let(:gem) { 'rake' }

      it 'return nil' do
        expect(subject).to be_nil
      end
    end
  end

  context '#require_dir' do
    subject { require_dir(directory) }

    context 'when directory is invalid' do
      let(:directory) { 'invalid_directory_1' }
      let(:error_message) { "Directory '#{directory}' does not exist" }

      it 'raise a StandardError with message for a directory' do
        expect{ subject }.to raise_error(StandardError, error_message)
      end
    end

    context 'when directory is valid' do
      let(:directory) { 'spec/fixtures/without_subdirectories/without_errors' }

      it 'return nil' do
        expect(subject).to be_nil
      end
    end
  end

  context '#require_dirs' do
  end

  context '#require_gems' do
  end
end
