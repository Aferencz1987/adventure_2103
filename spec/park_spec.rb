require './lib/trail'
require './lib/park'
require './lib/hiker'

RSpec.describe Park do
  it 'exist' do
    park1 = Park.new('Capitol Reef')

    expect(park1).to be_instance_of(Park)
  end

  it 'has attributes' do
    park1 = Park.new('Capitol Reef')

    expect(park1.name).to eq("Capitol Reef")
  end

  it 'tracks trails' do
    park1 = Park.new('Capitol Reef')
    trail1 = Trail.new({name: 'Grand Wash', length: '2.2 miles', level: :easy})
    trail2 = Trail.new({name: 'Cohab Canyon', length: '1.7 miles', level: :moderate})

    expect(park1.trails).to eq([])
    park1.add_trail(trail1)
    park1.add_trail(trail2)
    expect(park1.trails).to eq([trail1, trail2])
  end

  it 'shows trails shorter than' do
    park1 = Park.new('Capitol Reef')
    park2 = Park.new('Bryce Canyon')
    trail1 = Trail.new({name: 'Grand Wash', length: '2.2 miles', level: :easy})
    trail2 = Trail.new({name: 'Cohab Canyon', length: '1.7 miles', level: :moderate})
    trail3 = Trail.new({name: 'Chimney Rock Loop', length: '3.6 miles', level: :strenuous})
    trail4 = Trail.new({name: "Queen's/Navajo Loop", length: '2.9 miles', level: :moderate})
    trail5 = Trail.new({name: 'Rim Trail', length: '11 miles', level: :easy})
    trail6 = Trail.new({name: 'Tower Bridge', length: '3 miles', level: :moderate})

    park1.add_trail(trail1)
    park1.add_trail(trail2)
    park1.add_trail(trail3)
    park2.add_trail(trail4)
    park2.add_trail(trail5)
    park2.add_trail(trail6)
    expect(park1.trails_shorter_than(2.5)).to eq([trail1, trail2])
    expect(park2.trails_shorter_than(2.5)).to eq([])
  end

  it 'shows hikeable miles' do
    park1 = Park.new('Capitol Reef')
    park2 = Park.new('Bryce Canyon')
    trail1 = Trail.new({name: 'Grand Wash', length: '2.2 miles', level: :easy})
    trail2 = Trail.new({name: 'Cohab Canyon', length: '1.7 miles', level: :moderate})
    trail3 = Trail.new({name: 'Chimney Rock Loop', length: '3.6 miles', level: :strenuous})
    trail4 = Trail.new({name: "Queen's/Navajo Loop", length: '2.9 miles', level: :moderate})
    trail5 = Trail.new({name: 'Rim Trail', length: '11 miles', level: :easy})
    trail6 = Trail.new({name: 'Tower Bridge', length: '3 miles', level: :moderate})
    park1.add_trail(trail1)
    park1.add_trail(trail2)
    park1.add_trail(trail3)
    park2.add_trail(trail4)
    park2.add_trail(trail5)
    park2.add_trail(trail6)

    expect(park1.hikeable_miles).to eq(7.5)
    expect(park2.hikeable_miles).to eq(16.9)
  end
  it 'sorts trails by difficulty' do
    park1 = Park.new('Capitol Reef')
    park2 = Park.new('Bryce Canyon')
    trail1 = Trail.new({name: 'Grand Wash', length: '2.2 miles', level: :easy})
    trail2 = Trail.new({name: 'Cohab Canyon', length: '1.7 miles', level: :moderate})
    trail3 = Trail.new({name: 'Chimney Rock Loop', length: '3.6 miles', level: :strenuous})
    trail4 = Trail.new({name: "Queen's/Navajo Loop", length: '2.9 miles', level: :moderate})
    trail5 = Trail.new({name: 'Rim Trail', length: '11 miles', level: :easy})
    trail6 = Trail.new({name: 'Tower Bridge', length: '3 miles', level: :moderate})
    park1.add_trail(trail1)
    park1.add_trail(trail2)
    park1.add_trail(trail3)
    park2.add_trail(trail4)
    park2.add_trail(trail5)
    park2.add_trail(trail6)
    expect(park1.trails_by_level).to eq({:easy => ["Grand Wash"], :moderate => ["Cohab Canyon"], :strenuous => ["Chimney Rock Loop"]})

    expect(park2.trails_by_level).to eq({:moderate => ["Queen's/Navajo Loop", "Tower Bridge"], :easy => ["Rim Trail"]})
  end

  it 'tracks visitors' do
    trail1 = Trail.new({name: 'Rim Trail', length: '11 miles', level: :easy})
    trail2 = Trail.new({name: "Queen's/Navajo Loop", length: '2.9 miles', level: :moderate})
    trail3 = Trail.new({name: 'Tower Bridge', length: '3 miles', level: :moderate})
    trail4 = Trail.new({name: 'Peekaboo Loop', length: '5.5 miles', level: :strenuous})
    park = Park.new('Bryce Canyon')
    park.add_trail(trail1)
    park.add_trail(trail2)
    park.add_trail(trail3)
    park.add_trail(trail4)
    hiker1 = Hiker.new('Dora', :moderate)
    hiker2 = Hiker.new('Frank', :easy)
    hiker3 = Hiker.new('Jack', :strenuous)
    hiker4 = Hiker.new('Sally', :strenuous)
    #This visit occurs on 6 23, 1980
    hiker1.visit(park)
    #This visit occurs on 6 24, 1980
    hiker2.visit(park)
    #This visit occurs on 6 24, 1980
    hiker3.visit(park)
    #This visit occurs on 6 25, 1980
    hiker4.visit(park)
    #This visit occurs on 6 23, 2020
    hiker1.visit(park)
    #This visit occurs on 6 24, 2020
    hiker2.visit(park)
    #This visit occurs on 6 24, 2020
    hiker3.visit(park)
    #This visit occurs on 6 25, 2020
    hiker4.visit(park)
    expect(park.visitors_log).to eq(
    {
     1980 => {
       "06/23" => {
         hiker1 => [trail2, trail3]
       },
       "06/24" => {
         hiker2 => [trail1],
         hiker3 => [trail4]
       },
       "06/25" => {
         hiker4 => [trail4]
       }
     },
     2020 => {
       "06/23" => {
         hiker1 => [trail2, trail3]
       },
       "06/24" => {
         hiker2 => [trail1],
         hiker3 => [trail4]
       },
       "06/25" => {
         hiker4 => [trail4]
       }
     },
    })
  end
end
