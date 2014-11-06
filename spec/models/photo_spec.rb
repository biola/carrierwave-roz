require 'spec_helper'

describe Photo do
  let(:domain) { 'http://example.com'}
  let(:base_path) { 'dummyaccessid/custom/store/dir' }
  let(:filename) { 'zoidberg.jpg' }
  let(:original_path) { "#{base_path}/#{filename}" }
  let(:small_path) { "#{base_path}/small_#{filename}" }
  let(:medium_path) { "#{base_path}/medium_#{filename}" }
  let(:large_path) { "#{base_path}/large_#{filename}" }
  let(:original_url) { "#{domain}/#{base_path}/#{filename}" }
  let(:small_url) { "#{domain}/#{base_path}/small_#{filename}" }
  let(:medium_url) { "#{domain}/#{base_path}/medium_#{filename}" }
  let(:large_url) { "#{domain}/#{base_path}/large_#{filename}" }

  let(:name) { 'Why not?' }
  let(:file_path) { File.expand_path("../../fixtures/#{filename}", __FILE__) }
  let(:file) { File.open(file_path) }
  subject(:photo) { Photo.create name: name, file: file }

  context 'after create' do
    it 'renders the file URL correctly' do
      expect(photo.file.url).to eql original_url
    end

    it 'renders the file version URLs correctly' do
      expect(photo.file.url(:small)).to eql small_url
      expect(photo.file.url(:medium)).to eql medium_url
      expect(photo.file.url(:large)).to eql large_url
    end
  end

  context 'after load from database' do
    let(:photo_id) { Photo.create(name: name, file: file).id }
    subject(:photo) { Photo.find(photo_id) }

    it 'renders the file URL correctly' do
      expect(photo.file.url).to eql original_url
    end

    it 'renders the file version URLs correctly' do
      expect(photo.file.url(:small)).to eql small_url
      expect(photo.file.url(:medium)).to eql medium_url
      expect(photo.file.url(:large)).to eql large_url
    end
  end

  describe '#save' do
    it 'calls Client#upload for each version' do
      paths = []
      CarrierwaveRoz::Client.any_instance.stub(:upload) do |_, _, path|
        paths << path
        OpenStruct.new(code: 200)
      end

      Photo.create name: name, file: file
      expect(paths.length).to eql 4
      expect(paths).to include original_path
      expect(paths).to include small_path
      expect(paths).to include medium_path
      expect(paths).to include large_path
    end
  end
end
