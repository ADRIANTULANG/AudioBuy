<?php
include 'conn.php'; 
$result=array();
try {
    
$serviceName = $_POST['serviceName'];
$servicePrice = $_POST['servicePrice'];
$serviceDescription = $_POST['serviceDescription'];
$serviceStoreID = $_POST['serviceStoreID'];
$serviceImage = $_POST['serviceImage'];

$queryResult=$connect->query("INSERT INTO `tbl_services`( `serviceName`, `servicePrice`, `serviceDescription`, `serviceStoreID`, `serviceImage`) 
                                                    VALUES ('$serviceName','$servicePrice','$serviceDescription','$serviceStoreID','$serviceImage')");

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
