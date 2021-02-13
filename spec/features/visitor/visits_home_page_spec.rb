require 'rails_helper'

feature 'Visitor visits home page' do
    scenario 'Successfully' do
        visit root_path

        expect(page).to have_content('Tech Jobs')
        expect(page).to have_content('Encontre vagas de trabalho em tecnologia')
    end
end