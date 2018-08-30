require 'spec_helper'

RSpec.describe Classifier do
  context '#classify' do
    subject { Classifier.classify(elements) }

    context 'when list of elements is empty' do
      let(:elements) { [] }
      let(:classified_list) { { files: [], gems: [] } }

      it 'return hash with empty files list and empty gems list' do
        expect(subject).to eq classified_list
      end
    end

    context 'when a list of gems is informed' do
      let(:elements) { %w[rake rspec] }
      let(:classified_list) { { files: [], gems: elements } }

      it 'return hash with empty files list and a list of gems' do
        expect(subject).to eq classified_list
      end
    end

    context 'when a list of directories is informed' do
      let(:elements) { ['spec/fixtures/dependents', 'spec/fixtures/independents'] }
      let(:files) do
        [
          './spec/fixtures/dependents/x.rb',
          './spec/fixtures/dependents/z.rb',
          './spec/fixtures/independents/u.rb',
          './spec/fixtures/independents/v.rb'
        ]
      end
      let(:classified_list) { { files: files, gems: [] } }

      it 'return hash with empty gems list and a list of files' do
        expect(subject).to eq classified_list
      end
    end

    context 'when a list of files is informed' do
      let(:elements) { ['spec/fixtures/independents/v.rb', 'spec/fixtures/dependents/z.rb'] }
      let(:classified_list) { { files: elements, gems: [] } }

      it 'return hash with empty gems list and a list of files' do
        expect(subject).to eq classified_list
      end
    end

    context 'when a list of invalid elements is informed' do
      let(:elements) { ['invalid_1', 'invalid_2'] }
      let(:classified_list) { { files: [], gems: elements } }

      it 'return hash with empty files list and a list of gems' do
        expect(subject).to eq classified_list
      end
    end

    context 'when a list of all kind of elements is informed' do
      let(:elements) do
        [
          'rspec',
          'rake',
          'invalid_file1',
          'invalid_gem_1',
          'spec/fixtures/dependents',
          'spec/fixtures/independents/v.rb',
          'spec/fixtures/independents/u',
        ]
      end

      let(:classified_list) do
        {
          files: ['./spec/fixtures/dependents/x.rb',
                  './spec/fixtures/dependents/z.rb',
                  'spec/fixtures/independents/v.rb',
                  'spec/fixtures/independents/u'],
          gems: %w(rspec rake invalid_file1 invalid_gem_1)
        }
      end

      it 'return hash with a list of gems and a list of files' do
        expect(subject).to eq classified_list
      end
    end
  end
end
