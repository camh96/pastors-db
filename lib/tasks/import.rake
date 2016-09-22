namespace :import do
  desc 'Import pastor scoop database.'
  task pastorscoop: :environment do
    puts 'Importing pastorscoop data...'
    CSV.foreach('db/csvs/Pastors Co-Op Database v13.csv', headers: true, :encoding => 'windows-1251:utf-8') do |row|
      new_church_from_pastors_coop_row(row)
    end
  end

  desc 'Import church database.'
  task church_database: :environment do
    puts 'Importing church_database data...'
    CSV.foreach('db/csvs/ORIGINAL Church Database v11.csv', headers: true, :encoding => 'windows-1251:utf-8') do |row|
      new_church_from_church_db_row(row)
    end
  end

  def new_church_from_church_db_row row
    pastorscoop = row['ARISE Connect'].present?

    attributes = {
      name: row['Church']&.strip,
      name_alternative: row['AKA']&.strip,
      denomination: row['Denomination']&.strip,
      address: row['Address']&.strip,
      suburb: row['Suburb']&.strip,
      city: row['TownCity']&.strip,
      postcode: row['Postcode']&.strip,
      region: row['Region']&.strip,
      country: 'New Zealand',
      email: row['Email']&.strip,
      email_alternate: nil,
      facebook: row['Facebook ID']&.strip,
      landline_tel: row['MainPhone']&.strip,
      landline_tel_alternate: row['AlternatePhone']&.strip,
      pastorscoop: pastorscoop,
      # active: true, // hard coded, not quite sure what this is
      website: row['Website']&.strip,
      notes: row['Notes']&.strip
    }      

    church = Church.create(attributes)

    if church
      attributes = {
        first_name: row['Senior Pastor']&.strip,
        last_name: row['Surname']&.strip,
        pastorscoop: pastorscoop
      }
      person = Person.create(attributes)
      church.people << person if person.valid?

      attributes = {
        first_name: row['Senior Pastor2']&.strip,
        last_name: row['Surname']&.strip,
        pastorscoop: pastorscoop
      }
      person = Person.create(attributes)
      church.people << person if person.valid?

    end

    return church
  end

  def new_church_from_pastors_coop_row row
    attributes = {
      name: row['Church']&.strip,
      name_alternative: nil,
      denomination: nil,
      address: row['Church Postal Address']&.strip,
      suburb: nil,
      city: row['City']&.strip,
      postcode: row['Postcode']&.strip,
      country: row['Country']&.strip,
      email: row['Church Email Address']&.strip,
      email_alternate: nil,
      facebook: nil,
      landline_tel: row['Church Number']&.strip,
      landline_tel_alternate: nil,
      pastorscoop: true,
      active: true,
      website: row['Church Website']&.strip,
      notes: row['Notes']&.strip
    }

    # Adjust for NZ
    if attributes[:country] == 'NZ'
      attributes[:country] = 'New Zealand'
    end
      

    church = Church.create(attributes)

    if church
      person = new_pastor_from_church(row, 'His')
      church.people << person if person.valid?

      person = new_pastor_from_church(row, 'Her')
      church.people << person if person.valid?
    end

    return church
  end

  def new_pastor_from_church(row, gender_prefix = 'His')
    attributes = {
      first_name: row[gender_prefix + ' Name']&.strip,
      last_name: row['Surname']&.strip,
      role: row['Pastors']&.strip,
      mobile_tel: row[gender_prefix + ' Cellphone']&.strip,
      email: row[gender_prefix + ' Email']&.strip,
      pastorscoop: true,
      gender: (gender_prefix == 'His' ? 'Male' : 'Female')
    }

    return Person.create(attributes)
  rescue ActiveRecord::RecordInvalid
  end
end
