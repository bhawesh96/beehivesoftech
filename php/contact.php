<?php 

 //Connect to database
 	include_once('conn.php');

 if(!$db_selected)
 {
 	die('cannot access' . $dbname . ':' . mysql_error());
  }

//Fetch HTML form details
 $email = $_POST['email'];
 $phone = $_POST['phone'];
 $message = $_POST['message'];
 

 $sql = "INSERT INTO contactform (email, phone, message) VALUES ('$email', '$phone', '$message')";  		

 if(!mysql_query($sql))
 {
 	echo mysql_error();
 }

 else{
 	echo 'Your message has been successfully sent!';
 }

 mysql_close();

// $email = strip_tags(htmlspecialchars($_POST['email']));
// $phone = strip_tags(htmlspecialchars($_POST['phone']));
// $message = strip_tags(htmlspecialchars($_POST['message']));
   
// $to = 'cribblservices@gmail.com'; 
// $email_subject = "From  $email";
// $email_body = "New message\n\n"."Here are the details:\n\nEmail: $email\n\nPhone: $phone\n\nMessage:\n$message";
// $headers = "From: webmail\n";
// $headers .= "Reply-To: $email";   
// mail($to,$email_subject,$email_body,$headers);
// echo "mailed";
// return true;         

 ?>
