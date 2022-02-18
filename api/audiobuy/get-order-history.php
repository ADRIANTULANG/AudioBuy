<?php
include 'conn.php'; 
$result=array();
try {
$customerid = $_POST['customerid'];
$queryResult=$connect->query("SELECT * FROM `tbl_store_products_transaction` WHERE customerid = '$customerid'");

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
