//@ts-check

//todo only allow specified url
self.addEventListener('fetch', function (event) {
  event.respondWith(
    handleCallback(event.request)
    .then((parameters) => {
      return new Response('<p>Logging in...</p>', {
        headers: { 'Content-Type': 'text/html' }
      })
    }).catch((error) => {
      console.error('Failed to log in.')
      console.error(error);  
    })
  );
});

function handleCallback(request) {
  return new Promise((resolve, reject) => {
    if(!request || !request.url) {
      var error = {
        error: 'invalid_request',
        error_description: 'The received callback request was invalid' + request
      }
      notifyCallbackListener(error);
      reject(error);
    }
    notifyCallbackListener(request.url)
    resolve(request.url);
    //todo remove unnecessary stuff
    //var requestUrl = new URL(request.url);
    //var parameters = parseQueryParameters(requestUrl);
    //notifyCallbackListener(parameters);
    //resolve(parameters);
  })
}

function parseQueryParameters(requestUrl){
  var parameterMap = {};
  var queryParameters = requestUrl.searchParams;
  for(var parameterPair of queryParameters.entries()){
    var key = parameterPair[0];
    var value = parameterPair[1];
    parameterMap[key] = value;    
  }
  return parameterMap;
}

function notifyCallbackListener(parameters){
  var oauthCallbackChannel = new BroadcastChannel('oauth_callback')
  oauthCallbackChannel.postMessage(parameters);
}
