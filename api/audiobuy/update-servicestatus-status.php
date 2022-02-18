<?php
include 'conn.php'; 
$result=array();
try {
$status = $_POST['status'];
$transactionID = $_POST['transactionID'];

$queryResult=$connect->query("UPDATE `tbl_order_services` SET `status`='$status' WHERE transactionNo = '$transactionID'");

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
