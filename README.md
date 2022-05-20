# DisneyCruiseInterview

The Architecture design is focused around two areas: APIs and UIs. APIs were named after their respective URL parameters to keep code clarity between backend and frontend teams. UIs are separated by screens such as a grouping for the comics list screen and character selection screen. The code is based around being modular where APIs don’t need to conform to specific View Controllers and can be used within the app without needing to create new functions to call APIs. View controllers were also designed around extensions using protocols to keep code clean and lean. 

Areas that would need to be improved upon would be a cleaner way of handling errors and letting the user know that a network call has failed and allowing them to attempt to retry an API call. Another great improvement would be to add search to the character selection as well as the comic title selection giving users more control of what results they will get. 

For Unit Tests I went with two that covered the APIs. One for making sure the codable object can be decoded without errors without using the API call itself (incase API server is down). Second is for the API itself testing we are able to get back a 200 response.
