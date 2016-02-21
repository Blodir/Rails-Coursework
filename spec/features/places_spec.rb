require 'rails_helper'
describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if three is returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ),  Place.new( name:"Hassula", id: 2 ),  Place.new( name:"OlenTonttupuvussa", id: 3 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Hassula"
    expect(page).to have_content "OlenTonttupuvussa"
  end

  it "if none is returned by the API" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        []
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end
