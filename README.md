### Description
Upload a file asynchronously in Firefox 3.5+, Chrome and Safari

### Documentation
The plugin is self-documenting with descriptive event names each of which takes a callback. Here are the additional options.

*   url  
    The URL to upload the file to

*   fields  
    A hash of additional fields that should be passed along in the request. For instance, a Rails app would want to pass along an authenticity_token field

*   method  
    The HTTP method to be used. Default is POST.

The parameter name sent to the server will be taken from the name attribute of the input field. If the name attribute does not exist then 'file' will be used instead.

The included sample shows a typical implementation. Ruby and Sinatra are required to run the sample.

