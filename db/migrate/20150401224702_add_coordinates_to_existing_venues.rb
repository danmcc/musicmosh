class AddCoordinatesToExistingVenues < ActiveRecord::Migration

  def data

    venues = {
      "Bimbo's 365 Club" => {
        :latitude => 37.803756,
        :longitude => -122.415525
      },

      "Bottom Of The Hill" => {
        :latitude => 37.76499,
        :longitude => -122.396435
      },

      "Dolby Theatre" => {
        :latitude => 34.0694333,
        :longitude => -118.339521
      },

      "Echoplex" => {
        :latitude => 34.077657,
        :longitude => -118.260479
      },

      "Nokia Theatre LA Live" => {
        :latitude => 34.044403,
        :longitude => -118.267087
      },

      "Ruby Skyes" => {
        :latitude => 37.7875072,
        :longitude => -122.4073588
      },

      "Staples Center" => {
        :latitude => 34.043018,
        :longitude => -118.267254
      },

      "The Fillmore" => {
        :latitude => 37.7851713,
        :longitude => -118.267254
      },

      "The Roxy Theatre" => {
        :latitude => 34.090908,
        :longitude => -122.4328185
      },

      "The Warfield" => {
        :latitude => 37.782739,
        :longitude => -122.410156
      },

      "The Wiltern" => {
        :latitude => 34.061446,
        :longitude => -118.30884
      },

      "Allstate Arena" => {
        :latitude => 42.005258,
        :longitude => -87.88783
      },

      "Bottom Lounge" => {
        :latitude => 41.885217,
        :longitude => -87.661728
      },

      "First Mid Westbank Amphitheatre" => {
        :latitude => 41.543939,
        :longitude => -87.775923
      },

      "The Chicago Theatre" => {
        :latitude => 41.885499,
        :longitude => -87.62757
      },

      "House Of Blues" => {
        :latitude => 34.094666,
        :longitude => -118.373629
      },

      "The Colosseum Caesars Palace" => {
        :latitude => 36.117832,
        :longitude => -115.174958
      },

      "Barclays Center" => {
        :latitude => 40.682524,
        :longitude => -73.975013
      },

      "Beacon Theatre" => {
        :latitude => 40.780522,
        :longitude => -73.981041
      },

      "Bowery Ballroom" => {
        :latitude => 40.720406,
        :longitude => -73.993358
      },

      "Madison Square Garden" => {
        :latitude => 40.750504,
        :longitude => -73.993439
      },

      "Mercury Lounge" => {
        :latitude => 40.722108,
        :longitude => -73.986794
      },

      "Terminal 5 Music" => {
        :latitude => 40.769778,
        :longitude => -73.993118
      },

      "Chameleon Club" => {
        :latitude => 40.04154,
        :longitude => -76.308916
      }
    }

    say_with_time 'Adding coordinates to existing venues' do

      Venue.all.each do |v|

        unless venues[v.name].nil?
          v.latitude = venues[v.name][:latitude]
          v.longitude = venues[v.name][:longitude]
          v.save
        end

      end
    end

  end
end
