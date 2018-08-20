require "spec_helper"

RSpec.describe RequireSmasher do
  context '#require_all' do
    subject { require_all(require_1, require_2, require_3, require_4) }

    context 'when required list is invalid' do
      let(:require_1) { 'spec/fixtures/without_subdirectories/without_errors' }
      let(:require_2) { 'rake' }
      let(:require_3) { 'invalid_directory_1' }
      let(:require_4) { 'invalid_gem_1' }
      let(:error_message) { "cannot load such file -- #{require_3}" }

      it 'raise a StandardError with message for gems and directories' do
        expect{ subject }.to raise_error(LoadError, error_message)
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
      let(:error_message) { "cannot load such file -- #{gem}" }

      it 'raise a LoadError with message for a gem' do
        expect{ subject }.to raise_error(LoadError, error_message)
      end
    end

    context 'when gem is valid' do
      let(:gem) { 'rake' }

      it 'return a list of required gems' do
        expect(subject).to eq ['rake']
      end
    end
  end

  context '#require_file' do
    subject { require_file(file) }

    context 'when file is invalid' do
      let(:file) { 'invalid_file_1' }
      let(:error_message) { "cannot load such file -- #{file}" }

      it 'raise a StandardError' do
        expect{ subject }.to raise_error(StandardError, /Error while requiring file invalid_file_1: cannot load such file/)
      end
    end

    context 'when file is valid' do
      context 'when file does not have Ruby extension' do
        let(:file) { 'spec/fixtures/independents/u' }

        it 'return nil' do
          expect(subject).to be_nil
        end
      end

      context 'when file has Ruby extension' do
        let(:file) { 'spec/fixtures/independents/v.rb' }

        it 'return nil' do
          expect(subject).to be_nil
        end
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
    context 'when directories are not informed' do
      subject { require_dirs }
      let(:error_message) { 'Directory was not informed' }

      it 'raise a StandardError with message' do
        expect{ subject }.to raise_error(StandardError, error_message)
      end
    end

    context 'when directories are valid' do
      context 'when just one directory is informed' do
        subject { require_dirs(directory) }
        let(:directory) { 'spec/fixtures/with_subdirectories/without_errors' }

        it 'return nil' do
          expect(subject).to eq nil
        end
      end

      context 'when many directories are informed' do
        subject { require_dirs(directory_1, directory_2) }
        let(:directory_1) { 'spec/fixtures/with_subdirectories/without_errors' }
        let(:directory_2) { 'spec/fixtures/without_subdirectories/without_errors' }

        it 'return nil' do
          expect(subject).to eq nil
        end
      end
    end

    context 'when exists cross directories dependencies' do
      subject { require_dirs(directory_1, directory_2) }

      let(:directory_1) { 'spec/fixtures/with_cross_dependences/cross_1' }
      let(:directory_2) { 'spec/fixtures/with_cross_dependences/cross_2' }

      it 'return nil' do
        expect(subject).to eq nil
      end
    end
  end

  context '#require_gems' do
    context 'when gems are valid' do
      context 'when just one gem is informed' do
        subject { require_gems('rspec') }

        it 'return a list of required gems' do
          expect(subject).to eq ['rspec']
        end
      end

      context 'when many gems are informed' do
        subject { require_gems('rspec', 'rake') }

        it 'return a list of required gems' do
          expect(subject).to eq ['rspec', 'rake']
        end
      end
    end
  end

  context '#require_files' do
    context 'when files are valid' do
      context 'when just one file is informed' do
        subject { require_files('spec/fixtures/independents/v.rb') }

        it 'return nil' do
          expect(subject).to be_nil
        end
      end

      context 'when many files are informed' do
        subject { require_files('spec/fixtures/independents/v.rb', 'spec/fixtures/independents/u') }

        it 'return nil' do
          expect(subject).to be_nil
        end
      end
    end
  end
end
