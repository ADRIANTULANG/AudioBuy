<?php
include 'conn.php'; 
$result=array();
try {
$customerid = $_POST['customerid'];
$currentDate = date('YmdH:i-s');

$stamp = strtotime("now");
$orderid = 'TRNSCTN-'.$stamp.'-'.$customerid.'-'.$currentDate; 
$orderid = str_replace(".", "", $orderid); 
    

$servicesID =  $_POST['servicesID'];
$serviceName =  $_POST['serviceName'];
$servicePrice =  $_POST['servicePrice'];
$serviceDescription =  $_POST['serviceDescription'];
$serviceStoreID =  $_POST['serviceStoreID'];
$serviceImage=  $_POST['serviceImage'];
$serviceRentalDate_from=  $_POST['serviceRentalDate_from'];
$serviceRentalDate_to=  $_POST['serviceRentalDate_to']; 
$status = 'Pending';
$note=  $_POST['note'];   
$customercontactno =  $_POST['customercontactno']; 

$ordernumber = $orderid;

$queryResult=$connect->query("INSERT INTO `tbl_order_services`
( `transactionNo`, `servicesID`, `serviceName`, `servicePrice`, `serviceDescription`, `serviceStoreID`, `serviceImage`, `serviceRentalDate_from`, `serviceRentalDate_to`, `status`, `note`, `customerid`, `customercontactno`)
 VALUES ('$ordernumber','$servicesID','$serviceName','$servicePrice','$serviceDescription','$serviceStoreID','$serviceImage','$serviceRentalDate_from','$serviceRentalDate_to','$status','$note','$customerid','$customercontactno')");

// while($fetchData=$queryResult->fetch_assoc()){
// $result[]=$fetchData;
// }
$result = array(

	'success' => true, 'data' => $ordernumber, 'message' => 'Success'

);
} catch (Exception $e) {
	$result = array(

        'success' => false, 'message' => 'Error. Please try again. ' . $e

    );
}
echo json_encode($result);
?>
