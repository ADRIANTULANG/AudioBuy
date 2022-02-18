<?php
include 'conn.php'; 
$result=array();
try {

$serviceID = $_POST['serviceID'];

$queryResult=$connect->query("DELETE FROM `tbl_services` WHERE servicesID = '$serviceID'");

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
