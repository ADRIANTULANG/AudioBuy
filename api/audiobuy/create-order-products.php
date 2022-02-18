<?php
include 'conn.php'; 
$result=array();
try {

// $currentDate = date('YmdH:i-s');

// $stamp = strtotime("now");
// $orderid = 'TRNSCTN-'.$stamp.'-'.$REMOTE_ADDR.''.$userid.'-'.$currentDate; 
// $orderid = str_replace(".", "", $orderid); 
    
$productImage= $_POST['productImage'];
$productStoreID = $_POST['productStoreID'];
$productDescription = $_POST['productDescription'];
$productPrice = $_POST['productPrice'];
$productName = $_POST['productName'];
$productID = $_POST['productID'];
$productQuantity =  $_POST['productQuantity'];
$ordernumber = $_POST['ordernumber'];

$queryResult=$connect->query("INSERT INTO `tbl_order_products`(`ordernumber`, `productID`, `productName`, `productPrice`, `productDescription`, `productStoreID`, `productImage`, `productQuantity`)
                             VALUES ('$ordernumber','$productID','$productName','$productPrice','$productDescription','$productStoreID','$productImage','$productQuantity')");

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
