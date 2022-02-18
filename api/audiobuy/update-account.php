<?php
include 'conn.php'; 
$result=array();
try {
$storename = $_POST['storename'];
$storeaddress = $_POST['storeaddress'];
$storeusername = $_POST['storeusername'];
$storepassword = $_POST['storepassword'];
$storeid = $_POST['storeid']; 
$storecontactno = $_POST['storecontactno'];
$storeimage = $_POST['storeimage'];



$queryResult=$connect->query("UPDATE `tbl_customers` 
SET `user`='$storeusername',`pass`='$storepassword',`name`='$storename',`contactno`='$storecontactno',`image`='$storeimage',`address`='$storeaddress'
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
