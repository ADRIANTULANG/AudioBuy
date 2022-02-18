<?php
include 'conn.php'; 
$result=array();
try {
$username = $_POST['username'];
$password = $_POST['password'];



$queryResult=$connect->query("SELECT * FROM `tbl_customers` WHERE user = '$username' and pass= '$password'");

while($fetchData=$queryResult->fetch_assoc()){
$result[]=$fetchData;
}
$data = array(

	'success' => true, 'data'=> $result, 'message' => 'Success'

);
} catch (Exception $e) {
	$data = array(

        'success' => false, 'message' => 'Error. Please try again. ' . $e

    );
}
echo json_encode($data);
?>
