require "spec_helper"

RSpec.describe RequireElements do
  subject { RequireElements.require_elements(elements, require_module) }

  context '#require_elements' do
    context 'when just one element is required' do
      context 'when a gem is required' do
        context 'when a gem is invalid' do
          let(:elements) { ['invalid_gem_1'] }
          let(:require_module) { RequireGem }
          let(:error_message) { "Error requering gem '#{elements.first}': cannot load such file -- #{elements.first}" }

          it 'raise a StandardError with message for a gem' do
            expect{ subject }.to raise_error(StandardError, error_message)
          end
        end

        context 'when a gem is valid' do
          let(:elements) { ['rspec'] }
          let(:require_module) { RequireGem }

          it 'return nil' do
            expect(subject).to be_nil
          end
        end
      end

      context 'when a directory is required' do
        context 'when a directory is invalid' do
          let(:elements) { ['invalid_directory_1'] }
          let(:require_module) { RequireDir }
          let(:error_message) { "Directory '#{elements.first}' does not exist" }

          it 'raise a StandardError with message for a directory' do
            expect{ subject }.to raise_error(StandardError, error_message)
          end
        end

        context 'when a directory is valid' do
          let(:elements) { ['spec/fixtures/without_subdirectories/without_errors'] }
          let(:require_module) { RequireDir }

          it 'return nil' do
            expect(subject).to be_nil
          end
        end
      end
    end

    context 'when more one element are required' do
      context 'when gems are required' do
        context 'when gems are invalid' do
          let(:elements) { ['rspec', 'invalid_gem_1', 'invalid_gem_2'] }
          let(:require_module) { RequireGem }
          let(:error_message) { [error_message_1, error_message_2].to_s }
          let(:error_message_1) { "Error requering gem '#{elements[1]}': cannot load such file -- #{elements[1]}" }
          let(:error_message_2) { "Error requering gem '#{elements[2]}': cannot load such file -- #{elements[2]}" }

          it 'raise a StandardError with message for many gems' do
            expect{ subject }.to raise_error(StandardError, error_message)
          end
        end

        context 'when gems are valid' do
          let(:elements) { ['rspec', 'rake'] }
          let(:require_module) { RequireGem }

          it 'return nil' do
            expect(subject).to be_nil
          end
        end
      end

      context 'when more one directory are required' do
        context 'when directories are invalid' do
          let(:elements) { ['spec/fixtures/without_subdirectories/without_errors', 'invalid_dir_1', 'invalid_dir_2'] }
          let(:require_module) { RequireDir }
          let(:error_message) { [error_message_1, error_message_2].to_s }
          let(:error_message_1) { "Directory '#{elements[1]}' does not exist" }
          let(:error_message_2) { "Directory '#{elements[2]}' does not exist" }

          it 'raise a StandardError with message for many directories' do
            expect{ subject }.to raise_error(StandardError, error_message)
          end
        end

        context 'when directories are valid' do
          let(:elements) { ['spec/fixtures/without_subdirectories/without_errors', 'spec/fixtures/with_subdirectories/without_errors'] }
          let(:require_module) { RequireDir }

          it 'return nil' do
            expect(subject).to be_nil
          end
        end
      end
    end
  end
end
