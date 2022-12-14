namespace :choose_random_couples do
    random_calendar_ids = ['mohamed.elsaid@gmail.com', 'nesma.emad@andela.com']

    def client_options
        {
          client_id: Rails.application.secrets.google_client_id,
          client_secret: Rails.application.secrets.google_client_secret,
          authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
          token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
          scope: Google::Apis::CalendarV3::AUTH_CALENDAR
        }
    end

    def build_auth(user)
        {
            access_token: user.access_token,
            expires_in: user.expires_in,
            token_type: user.token_type,
            scope: user.scope
        }
    end

    #this task should randomly couple people from the database and create events for them to meet in google calendar
    #it pulls the free dates for them and put the meeting on the time they are both free in
    task letsMeet: :environment do
        client = Signet::OAuth2::Client.new(client_options)
        start_date = Date.tomorrow.middle_of_day
        end_date = start_date + 30.minutes
    
        attendees = [{email: User.first.email}  , {email: User.second.email}  ]
        event = Google::Apis::CalendarV3::Event.new(summary: 'Cafe Society Time',
            description: "Let's meet and have fun",
            start: { date_time: start_date.to_datetime.rfc3339 },
            end: { date_time: end_date.to_datetime.rfc3339 },
            sendNotifications: true,
            attendees: attendees)


        client.update!(build_auth(User.first))
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
        service.insert_event(User.first.email, event)
    end
end
