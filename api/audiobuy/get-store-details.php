<?php
include 'conn.php'; 
$result=array();
try {
$storeid = $_POST['storeid'];




$queryResult=$connect->query("SELECT * FROM `tbl_customers` WHERE userid = '$storeid'");

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
