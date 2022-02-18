<?php
include 'conn.php'; 
$result=array();
try {
$providerid = $_POST['providerid'];

$queryResult=$connect->query("SELECT * FROM `tbl_order_services` WHERE serviceStoreID = '$providerid'");

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
