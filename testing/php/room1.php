<?php

$msg = $_GET['light1'];
//$string = $msg." ".$msg1." ".$msg2." ".$msg3;
$string = $msg;
echo $msg;
$myfile = fopen("room1.txt", "w") or die("Unable to open file!");
fwrite($myfile, $string);
fclose($myfile);
include "main.php"
?>