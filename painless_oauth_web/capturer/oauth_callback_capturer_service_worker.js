//@ts-check

//todo only allow specified redirect url
self.addEventListener('fetch', function (event) {
  event.respondWith(
    handleCallback(event.request)
    .then((parameters) => {
      return this.getWebPageResponse();
    }).catch((error) => {
      console.error('Failed to log in.')
      console.error(error);  
    })
  );
});

function handleCallback(request) {
  return new Promise((resolve, reject) => {
    if(!request || !request.url) {
      var error = 'invalid_request_captured';
      var errorDescription = 'The received callback request was invalid: ' + request;
      var errorObject = getErrorObject(error, errorDescription);
      var errorUriFragment = getErrorAsUriFragment(errorObject);
      notifyCallbackListener(errorUriFragment);
      reject(errorUriFragment);
    }
    notifyCallbackListener(request.url)
    resolve(request.url);
  })
}

/**
 * Notifies the main flutter app. According to the OAuth2 definition (https://tools.ietf.org/html/rfc6749#section-4.2.2), 
 * the callback parameters (E.g access token) are transferred in the url fragment: 
 * Example: http://example.com/callback#access_token=2323dasdsad&...
 * This parsing of the fragment is handled in dart code to reduce the complexity found in this rather "hidden"
 * file.
 * @param {String} urlWithFragment 
 */
function notifyCallbackListener(urlWithFragment){
  var oauthCallbackChannel = new BroadcastChannel('oauth_callback')
  oauthCallbackChannel.postMessage(urlWithFragment);
}

/**
 * Creates and returns a JSON error object.
 * @param {String} error 
 * @param {String} errorDescription 
 * @returns {*} json error object
 */
function getErrorObject(error, errorDescription){
  var errorObject = {
    error,
    errorDescription
  }
  return errorObject;
}

/**
 * Returns an error object as uri fragment. 
 * @param {*} errorObject 
 * @returns {String} errorUriFragment
 */
function getErrorAsUriFragment(errorObject){
  var errorParameters = new URLSearchParams(errorObject);
  var errorUriFragment = '#' + errorParameters.toString();
  return errorUriFragment;
}

/**
 * Returns the web page displayed / executed after the main app was notified. 
 * Mainly closes the current tab if the application is not running in an Iframe.
 * @returns {Response} web page response
 */
function getWebPageResponse(){
  return new Response(`
  <!DOCTYPE html>
  <body>
    <p>Authentication finished, you can now close this window...</p>
    <script>
      //from https://stackoverflow.com/questions/326069/how-to-identify-if-a-webpage-is-being-loaded-inside-an-iframe-or-directly-into-t (on 2020-04-19)
      function isRunningInIframe() {
        try {
            return window.self !== window.top;
        } catch (e) {
            return true;
        }
      }
      
      // From https://developer.mozilla.org/de/docs/Web/API/Window/close (on 2020-04-19)
      function closeCurrentWindow() {
        window.close();
      }
      
      var isRunningInPopup = !isRunningInIframe();
      if(isRunningInPopup){
        closeCurrentWindow();
      }
    </script>
  </body>`, {
    headers: { 'Content-Type': 'text/html' }
  })
}



