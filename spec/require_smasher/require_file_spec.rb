require "spec_helper"

RSpec.describe RequireFile do
  context '#require' do
    subject { RequireFile.require(files) }

    context 'when file is not informed' do
      let(:files) { [] }

      it 'raise FileNotInformedError' do
        expect{ subject }.to raise_error(FileNotInformedError, 'File was not informed')
      end
    end

    context 'when informed file does not exist' do
      let(:files) { ['inexistent_file'] }
      let(:error_message) { "Error while requiring file #{files.first}: cannot load such file" }

      it 'raise RequireFileError' do
        expect{ subject }.to raise_error(RequireFileError, /#{error_message}/)
      end
    end

    context 'when file is not a Ruby File' do
      context 'file with txt extension' do
        let(:files) { ['spec/fixtures/is_not_a_ruby_file.txt'] }

        it 'raise RequireFileError' do
          expect{ subject }.to raise_error(RequireFileError, /Error while requiring file/)
          expect{ subject }.to raise_error(RequireFileError, /cannot load such file/)
        end
      end

      context 'file without extension' do
        let(:files) { ['spec/fixtures/is_not_a_ruby_file'] }

        it 'raise RequireFileError' do
          expect{ subject }.to raise_error(RequireFileError, /Error while requiring file/)
          expect{ subject }.to raise_error(RequireFileError, /cannot load such file/)
        end
      end
    end

    context 'when is impossible to resolve interdependence files' do
      let(:files) do
        [
          'spec/fixtures/with_subdirectories/with_errors/m/m',
          'spec/fixtures/with_subdirectories/with_errors/o/o',
          'spec/fixtures/with_subdirectories/with_errors/p/p'
        ]
      end

      it 'raise RequireFileError' do
        expect{ subject }.to raise_error(RequireFileError, /uninitialized constant/)
        expect{ subject }.to raise_error(RequireFileError, /Error while requiring file/)
      end
    end

    context 'when a file with Ruby extension is required' do
      let(:files) { ['spec/fixtures/with_subdirectories/without_errors/i/i.rb'] }

      it 'return nil' do
        expect(subject).to be_nil
      end
    end

    context 'when a file without Ruby extension is required' do
      let(:files) { ['spec/fixtures/with_subdirectories/without_errors/i/i'] }

      it 'return nil' do
        expect(subject).to be_nil
      end
    end

    context 'when independent files are required' do
      let(:files) do
        [
          'spec/fixtures/independents/u.rb',
          'spec/fixtures/independents/v.rb'
        ]
      end

      it 'return nil' do
        expect(subject).to be_nil
      end
    end

    context 'when interdependent files are required' do
      let(:files) do
        [
          'spec/fixtures/dependents/x.rb',
          'spec/fixtures/dependents/z.rb'
        ]
      end

      it 'return nil' do
        expect(subject).to be_nil
      end
    end
  end

  context '#require_directories' do
    subject { RequireFile.require_directories(directories) }

    context 'when directory is not informed' do
      let(:directories) { [] }
      
      it 'raise DirNotInformedError' do
        expect{ subject }.to raise_error(DirNotInformedError, 'Directory was not informed')
      end
    end

    context 'when directory does not exist' do
      let(:directories) { ['dir'] }
      
      it 'raise DirNotExistError' do
        expect{ subject }.to raise_error(DirNotExistError, "Directory '#{directories.first}' does not exist")
      end
    end

    context 'when directory does not have sub-directories' do
      context 'when require dependencies are not solved' do
        let(:directories) { ['spec/fixtures/without_subdirectories/with_errors'] }

        it 'raise RequireFileError' do
          expect{ subject }.to raise_error(RequireFileError, /uninitialized constant/)
          expect{ subject }.to raise_error(RequireFileError, /Error while requiring file/)
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

        it 'raise RequireFileError' do
          expect{ subject }.to raise_error(RequireFileError, /uninitialized constant/)
          expect{ subject }.to raise_error(RequireFileError, /Error while requiring file/)
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
