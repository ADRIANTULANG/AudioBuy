<?php
include 'conn.php'; 
$result=array();
try {
$servicesStoreId = $_POST['servicesStoreId'];

$queryResult=$connect->query("SELECT * FROM `tbl_services` WHERE serviceStoreID = '$servicesStoreId'");

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
