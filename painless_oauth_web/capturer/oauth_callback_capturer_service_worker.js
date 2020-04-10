//todo only allow specified url
self.addEventListener('fetch', function (event) {
  event.respondWith(Promise.resolve().then(function() {
    handleCallback(event.request);
    console.log('--- SERVICE WORKER START ---');
    console.log(event.request);
    console.log('--- SERVICE WORKER END ---');
    return new Response('<p>Hallo from freundlichen Service-Worker!</p>', {
      headers: { 'Content-Type': 'text/html' }
    })
  }));
});

var handleCallback = function(request) {
  if(!request || !request.url) {
    return; //todo figur out what to do here
  }
  var parameterTransferObject = {};
  var requestUrl = new URL(request.url);
  var queryParameters = requestUrl.searchParams;
  for(parameterPair of queryParameters.entries()){
    var key = parameterPair[0];
    var value = parameterPair[1];
    parameterTransferObject[key] = value;    
  }
  console.log(parameterTransferObject);
    //var test = Array.from((new URL(event.request.url).searchParams).entries())
}
//var test = Array.from((new URL(event.request.url).searchParams).entries())