<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<head>
<script src="https://apis.google.com/js/platform.js" async defer></script>

<script>
  function onSignIn(googleUser) {
    // The user is signed in. You can get user details from googleUser.getBasicProfile().
    console.log('User signed in:', googleUser.getBasicProfile());
  }

  function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function() {
      console.log('User signed out.');
    });
  }
</script>


</head>
<body>


</body>
</html>