<?php
include 'conn.php'; 
$result=array();
try {
    
$productname = $_POST['productname'];
$productPrice = $_POST['productPrice'];
$ProductDescription = $_POST['ProductDescription'];
$productStoreID = $_POST['productStoreID'];
$productImage = $_POST['productImage'];

$queryResult=$connect->query("INSERT INTO `tbl_products`( `productName`, `productPrice`, `ProductDescription`, `productStoreID`, `productImage`) 
                                VALUES ('$productname','$productPrice','$ProductDescription','$productStoreID','$productImage')");

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
