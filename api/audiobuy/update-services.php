<?php
include 'conn.php'; 
$result=array();
try {
$serviceName = $_POST['serviceName'];
$servicePrice = $_POST['servicePrice'];
$serviceDescription = $_POST['serviceDescription'];
$serviceImage = $_POST['serviceImage'];
$serviceID = $_POST['serviceID'];



$queryResult=$connect->query("UPDATE `tbl_services` SET `serviceName`='$serviceName',`servicePrice`='$servicePrice',`serviceDescription`='$serviceDescription',`serviceImage`='$serviceImage'
                             WHERE servicesID = '$serviceID'");

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
