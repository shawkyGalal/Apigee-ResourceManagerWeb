/**
 * 
 */
	
	//---1-  For Building Authorization requerst ---- 
	function buildAuthReqWithPKCE(infraIndex ,  m_scope , m_anchorObjectId )
	{
		fetch('./moj-environments.json') // Replace 'data.json' with your actual file name and path
		.then(response => response.json()) // Parse the response as JSON
		.then(data => {
		  // Access and use the data object here
		  console.log(data);
			  // You can further process the data and display it on the page
		  buildAuthorizationLinkUsingPKCE(data , infraIndex , m_scope , m_anchorObjectId ) ;
		})
		.catch(error => {
		  console.error('Error fetching data:', error);
		});
	}

	function buildAuthorizationLinkUsingPKCE(m_configData , m_infraIndex , m_scope ,  m_anchorObjectId )
	{
		var result ; 
		var code_verifier = generateCodeVerifier(); 
		var code_challange = generateCodeChallenge(code_verifier); 
		setCookie('code_verifier', code_verifier, 1/24) ; 

		authorizationUrl = m_configData.Environments[m_infraIndex].nafath.authorizationUrl  ; 
		clientId = m_configData.Environments[m_infraIndex].credential.clientId ; 
		redirectUri = m_configData.Environments[m_infraIndex].nafath.redirectUri ; 
		var response_type = 'code' ; 
		var state = generateRandom(8) ; 
		var scope = m_scope ; //'openid' ;
		var nonce = generateRandom(8) ;  
		//https://api.cloudypedia.sa/oidc-core/oauth2/authorize?client_id=pGUORa3vPdXOZfQ9XfspYf7Shz4xEaaf&redirect_uri=yyyy&response_type=code&state=6r5yxu&scope=openid&nonce=06h2kn&force-authn=true&userId=null&code_challenge_method=S256&code_challenge=Ol-ccBIqBV_hpOmPr8xAGXFRGrW9gLVJGNyyNRuCWz8
		var result = authorizationUrl + '?client_id=' + clientId 
					+'&code_challange='+code_challange 
					+'&redirect_uri='+redirectUri
					+'&response_type=' + response_type
					+'&state=' + state
					+'&nonce=' + nonce
					+'&scope=' + scope 
					+'&force-authn='+false
					+'&code_challenge_method=S256'; 
		// Get the anchor element by its ID
		const myLink = document.getElementById(m_anchorObjectId);
		
		// Update the href attribute
		myLink.href = result;

		
	}



	// --2- For Getting AccessToken End point -----------
	function getTokenWithPKCE()
	{
		fetch('./moj-environments.json') // Replace 'data.json' with your actual file name and path
		.then(response => response.json()) // Parse the response as JSON
		.then(data => {
		  // Access and use the data object here
		  console.log(data);
		  // You can further process the data and display it on the page
		  printTokenUsingPKCE(data) ;
		})
		.catch(error => {
		  console.error('Error fetching data:', error);
		});
	}
	
	function printTokenUsingPKCE(configData )
	{
		const queryString = window.location.search;
		const params = new URLSearchParams(queryString);
		const code = params.get('code');
		//WARNING: For POST requests, body is set to null by browsers.
		var code_verifier = getCookie('code_verifier') ; 
		var client_id = configData.Environments[1].credential.clientId ; 
		var redirect_uri = configData.Environments[1].nafath.redirectUri ; 
		var tokenUrl = configData.Environments[1].nafath.tokenWithPkceUrl ; 
		var data = "grant_type=authorization_code&code="+code+"&redirect_uri="+redirect_uri+"&code_verifier="+code_verifier+"&client_id="+client_id;
			
		var xhr = new XMLHttpRequest();
		xhr.withCredentials = true;
			
		xhr.addEventListener("readystatechange", function() {
		  if(this.readyState === 4) {
		    console.log(this.responseText);
		    accessToken = this.responseText ; 
		    setCookie('accessToken' , accessToken , 0.01 ) ; 
		  }
		});
			
		xhr.open("POST", tokenUrl+"?client_id="+client_id);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		// WARNING: Cookies will be stripped away by the browser before sending the request.
		
		xhr.send(data);
	}		
	
	
	
		


 // Function to generate a random string for the code verifier
function generateCodeVerifier() {
  const charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
  const verifier = Array.from(crypto.getRandomValues(new Uint8Array(43)))
    .map((value) => charset[value % charset.length])
    .join('');
  return verifier;
}


// Function to generate the code challenge from the code verifier using SHA-256 
async function generateCodeChallenge(codeVerifier) {
  const encoder = new TextEncoder();

  const data = encoder.encode(codeVerifier) ; 
  const buffer = await crypto.subtle.digest('SHA-256', data);

  // Convert the buffer to base64 URL-encoded string
  const array = Array.from(new Uint8Array(buffer));
  const base64 = btoa(String.fromCharCode(...array))
    .replace(/=/g, '')
    .replace(/\+/g, '-')
    .replace(/\//g, '_');
  return base64;
}

function setCookie(name, value, daysToExpire) {
  const expirationDate = new Date();
  expirationDate.setDate(expirationDate.getDate() + daysToExpire);

  const cookieValue = encodeURIComponent(name) + '=' + encodeURIComponent(value) +
                      '; expires=' + expirationDate.toUTCString() +
                      '; path=/';

  document.cookie = cookieValue;
}


function getCookie(name) {
  const cookies = document.cookie.split(';');

  for (const cookie of cookies) {
    const [cookieName, cookieValue] = cookie.split('=');

    if (decodeURIComponent(cookieName.trim()) === name) {
      return decodeURIComponent(cookieValue);
    }
  }

  return null; // Cookie not found
}


function generateRandom(length) 
{
  const charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let nonce = '';

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * charset.length);
    nonce += charset.charAt(randomIndex);
  }
  return nonce;
}