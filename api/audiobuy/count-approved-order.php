<?php
include 'conn.php'; 
$result=array();
try {

$status = $_POST['status'];
$queryResult=$connect->query("SELECT COUNT(*) as counts FROM tbl_store_products_transaction WHERE status = '$status'");

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
