<?php
include 'conn.php'; 
$result=array();
try {
$providername = $_POST['providername'];
$provideraddress = $_POST['provideraddress'];
$providerusername = $_POST['providerusername'];
$providerpassword = $_POST['providerpassword'];
$storeid = $_POST['storeid']; 
$providercontact = $_POST['providercontact'];
$providerimage = $_POST['providerimage'];



$queryResult=$connect->query("UPDATE `tbl_customers` 
SET `user`='$providerusername',`pass`='$providerpassword',`name`='$providername',`contactno`='$providercontact',`image`='$providerimage',`address`='$provideraddress'
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
