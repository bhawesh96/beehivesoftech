<?php

$name = strip_tags(htmlspecialchars($_GET['name']));
$email_address = strip_tags(htmlspecialchars($_GET['email']));
$phone = strip_tags(htmlspecialchars($_GET['phone']));
$message = strip_tags(htmlspecialchars($_GET['message']));
   
$to = 'bhansalibhawesh85@gmail.com'; 
$email_subject = "From  $name";
$email_body = "New message\n\n"."Here are the details:\n\nName: $name\n\nEmail: $email_address\n\nPhone: $phone\n\nMessage:\n$message";
$headers = "From: webmail\n";
$headers .= "Reply-To: $email_address";   
mail($to,$email_subject,$email_body,$headers);
return true;         
?>