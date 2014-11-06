require 'spec_helper'

feature 'File storage' do
  let(:file_a) { File.expand_path('../../fixtures/zoidberg.jpg', __FILE__) }
  let(:file_b) { File.expand_path('../../fixtures/grebdioz.jpg', __FILE__) }

  scenario 'User uploads a photo' do
    visit photos_path
    click_link 'New Photo'
    fill_in 'Name', with: 'Why not?'
    attach_file('File', file_a)
    click_button 'Create Photo'

    expect(page).to have_content 'Why not?'
    expect(page).to have_selector 'img#small[src$="http://example.com/dummyaccessid/custom/store/dir/small_zoidberg.jpg"]'
    expect(page).to have_selector 'img#medium[src$="http://example.com/dummyaccessid/custom/store/dir/medium_zoidberg.jpg"]'
    expect(page).to have_selector 'img#large[src$="http://example.com/dummyaccessid/custom/store/dir/large_zoidberg.jpg"]'
    expect(page).to have_selector 'img#original[src$="http://example.com/dummyaccessid/custom/store/dir/zoidberg.jpg"]'
  end

  scenario 'User edits a photo' do
    Photo.create name: 'Why not?', file: File.open(file_a)

    visit photos_path
    click_link 'Why not?'
    click_link 'Edit'
    attach_file('File', file_b)
    click_button 'Update Photo'

    expect(page).to have_content 'Why not?'
    expect(page).to have_selector 'img#small[src$="http://example.com/dummyaccessid/custom/store/dir/small_grebdioz.jpg"]'
    expect(page).to have_selector 'img#medium[src$="http://example.com/dummyaccessid/custom/store/dir/medium_grebdioz.jpg"]'
    expect(page).to have_selector 'img#large[src$="http://example.com/dummyaccessid/custom/store/dir/large_grebdioz.jpg"]'
    expect(page).to have_selector 'img#original[src$="http://example.com/dummyaccessid/custom/store/dir/grebdioz.jpg"]'
  end

  scenario 'User deletes a photo' do
    Photo.create name: 'Why not?', file: File.open(file_a)

    visit photos_path
    click_link 'Why not?'
    click_button 'Delete Photo'

    expect(page).to_not have_content 'Why not?'
    expect(Photo.count).to eql 0
  end
end
