<?php 

	$username = 'root';
	$pass = 'pass';
	$dbname = 'civicq';
	$host = '139.59.17.132:3306';

	$db = @mysql_connect($host, $username, $pass);

	if(!$db){
		 die('failed to connect' . mysql_error());
	}

	$db_selected = @mysql_select_db($dbname, $db);


 ?>
