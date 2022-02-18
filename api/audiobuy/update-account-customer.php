<?php
include 'conn.php'; 
$result=array();
try {
$customername = $_POST['customername'];
$customeraddress = $_POST['customeraddress'];
$customerusername = $_POST['customerusername'];
$customerpassword = $_POST['customerpassword'];
$storeid = $_POST['storeid']; 
$customercontact = $_POST['customercontact'];
$customerimage = $_POST['customerimage'];



$queryResult=$connect->query("UPDATE `tbl_customers` 
SET `user`='$customerusername',`pass`='$customerpassword',`name`='$customername',`contactno`='$customercontact',`image`='$customerimage',`address`='$customeraddress'
WHERE userid = '$storeid'");

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
