<?php
include 'conn.php'; 
$result=array();
try {
$status = $_POST['status'];
$ordernumber = $_POST['ordernumber'];

$queryResult=$connect->query("UPDATE `tbl_store_products_transaction` SET `status`='$status' WHERE ordernumber = '$ordernumber'");

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
