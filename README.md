<a href="https://codeclimate.com/github/msimonborg/rate-your-rep"><img src="https://codeclimate.com/github/msimonborg/rate-your-rep/badges/gpa.svg" /></a>
#Rate Your Rep
#Calling is an effective way to participate in our democracy.
As more people catch on to this idea and make more calls, some elected officials will try to hide behind high call volumes and avoid picking up the phones. We need to hold them accountable.
#It's like Yelp for Congress.
Rate Your Rep lets you record your history and success rates for every call you make to Congress. You can rate and review your reps based on your satisfaction with the experience, view stats for each member, and share the results on social media (#TODO: integrate sharing).
#Let's remind them that they work for us.
A lot of members of Congress seem more interested in doing what's "good for business". So let's treat them like a business, except we're the owners, and it's time for their performance review.
#Installation
Clone this repo and then
```bash
bundle --without production
rake db:migrate
rake db:migrate SINATRA_ENV=test
rake spec
bundle exec shotgun
```
Then navigate to `localhost:9393` in your web browser.
#Data
Rep data is pulled from the [Phone Your Rep API](https://github.com/phoneyourrep/phone-your-rep-api). Data on reps and their offices that is assumed not to change is persisted to the database after the first time it is retrieved so it will be available in the index and for statistics. Every user request for location search and rep detail sends a new request to the API, and the local records are updated. Data that is not persisted and is only available from the API includes rep social media accounts, role in congress, district and state. This list of persisted data may grow in future updates.
#Contributing
Contributions are always welcome. Please check to see if there are any open issues first. Commit to a feature branch on your own fork and then submit your changes in a pull request.
#License
This project is licensed under the [MIT License](https://github.com/msimonborg/rate-your-rep/blob/master/LICENSE).
