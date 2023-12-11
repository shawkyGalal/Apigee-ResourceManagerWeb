<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<meta name="google-signin-client_id" content="743562068929-2m0gujbpdcs9g3gebrroeaj4hbkelc3b.apps.googleusercontent.com">

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<head>

<script src="https://apis.google.com/js/platform.js" async defer></script>
<script>
  function initGoogleSignIn() {
    gapi.load('auth2', function() {
      gapi.auth2.init();
    });
  }

  function onSignIn(googleUser) {
	  var profile = googleUser.getBasicProfile();
	  console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
	  console.log('Name: ' + profile.getName());
	  console.log('Image URL: ' + profile.getImageUrl());
	  console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
	}
  
</script>
</head>
<body>

<div class="g-signin2" data-onsuccess="onSignIn"></div>

</body>
</html>