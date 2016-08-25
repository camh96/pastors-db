namespace :import do
  desc 'TODO'
  task pastorscoop: :environment do
    puts 'Importing pastorscoop data...'
    CSV.foreach('db/csvs/Pastors Co-Op Database v13.csv', headers: true, :encoding => 'windows-1251:utf-8') do |row|
      new_church_from_row(row)
    end
  end

  def new_church_from_row row
    attributes = {
      name: row['Church'],
      name_alternative: nil,
      denomination: nil,
      address: row['Church Postal Address'],
      suburb: nil,
      city: row['City'],
      postcode: row['Postcode'],
      country: row['Country'],
      email: row['Church Email Address'],
      email_alternate: nil,
      facebook: nil,
      landline_tel: row['Church Number'],
      landline_tel_alternate: nil,
      pastorscoop: true,
      active: true,
      website: row['Church Website'],
      notes: row['Notes']
    }

    # Adjust for NZ
    if attributes[:country] == 'NZ'
      attributes[:country] = 'New Zealand'
    end
      

    church = Church.create(attributes)

    if church
      new_pastor_from_church(row, church, 'His')
      new_pastor_from_church(row, church, 'Her')
    end

    return church
  end

  def new_pastor_from_church(row, church, gender_prefix = 'His')
    attributes = {
      first_name: row[gender_prefix + ' Name'],
      last_name: row['Surname'],
      mobile_tel: row[gender_prefix + ' Cellphone'],
      email: row[gender_prefix + ' Email'],
      church_id: church.id
    }

    return Person.create(attributes)
  end
end
