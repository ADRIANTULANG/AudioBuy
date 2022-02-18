<?php
include 'conn.php'; 
$result=array();
try {

$productid = $_POST['productid'];

$queryResult=$connect->query("DELETE FROM `tbl_products` WHERE productID = '$productid'");

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
