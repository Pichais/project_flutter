<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$avata = $_GET['avata'];
		$user = $_GET['user'];
		$password = $_GET['password'];
		$name = $_GET['name'];
		$address = $_GET['address'];
		$phone = $_GET['phone'];
		$gender = $_GET['gender'];
		
							
		$sql = "INSERT INTO `user`(`id`, `avata`, `user`, `password`, `name`, `address`, `phone`, `gender`) VALUES (Null,'$avata','$user','$password','$name','$address','$phone','$gender')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Farm Mall";
   
}
	mysqli_close($link);
?>