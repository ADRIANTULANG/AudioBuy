<?php
include 'conn.php'; 
$result=array();
try {
$customerid = $_POST['customerid'];
$currentDate = date('YmdH:i-s');

$stamp = strtotime("now");
$orderid = 'TRNSCTN-'.$stamp.'-'.$customerid.'-'.$currentDate; 
$orderid = str_replace(".", "", $orderid); 
    
$status = 'Pending';
$storeid = $_POST['storeid'];

$customercontactno =  $_POST['customercontactno'];

$timeStamp =  $_POST['timeStamp'];
$ordernumber = $orderid;

$queryResult=$connect->query("INSERT INTO `tbl_store_products_transaction`( `ordernumber`, `timeStamp`, `customerid`, `storeid`, `status`,`customercontactno`)
                                     VALUES ('$ordernumber','$timeStamp','$customerid','$storeid','$status','$customercontactno')");

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
