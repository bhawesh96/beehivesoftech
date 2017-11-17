<?php

$name = strip_tags(htmlspecialchars($_GET['name']));
$email_address = strip_tags(htmlspecialchars($_GET['email']));
$phone = strip_tags(htmlspecialchars($_GET['phone']));
$message = strip_tags(htmlspecialchars($_GET['message']));
   
$to = 'team.robomanipal@gmail.com'; 
$email_subject = "From  $name";
$email_body = "Hello Robomanipal!\n\nYou have received a new message via the contact form of your website robomanipal.com\n\n"."Here are the details:\n\nName: $name\n\nEmail: $email_address\n\nPhone: $phone\n\nMessage:\n$message";
$headers = "From: webmail\n";
$headers .= "Reply-To: $email_address";   
mail($to,$email_subject,$email_body,$headers);

echo "message successfully sent";
echo "
<script>
window.location = 'http://robomanipal.com/contact.html';
</script>
";


return true;


?>

