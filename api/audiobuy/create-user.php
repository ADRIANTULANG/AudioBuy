<?php
include 'conn.php'; 
$result=array();
try {
$username = $_POST['username'];
$password = $_POST['password'];
$name = $_POST['name'];

$contactno = $_POST['contactno'];
$address = $_POST['address'];
$image = $_POST['image'];
$usertype = $_POST['usertype'];


$queryResult=$connect->query("INSERT INTO `tbl_customers`(`user`, `pass`, `name`, `contactno`, `image`, `address`, `usertype`) 
VALUES ('$username','$password','$name','$contactno','$image','$address','$usertype')");

// while($fetchData=$queryResult->fetch_assoc()){
// $result[]=$fetchData;
// }
$result = array(

	'success' => true, 'message' => 'Success'

);
} catch (Exception $e) {
	$result = array(

        'success' => false, 'message' => 'Error. Please try again. ' . $e

    );
}
echo json_encode($result);
?>
