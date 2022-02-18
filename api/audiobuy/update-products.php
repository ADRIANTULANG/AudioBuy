<?php
include 'conn.php'; 
$result=array();
try {
$productid = $_POST['productid'];
$productname = $_POST['productname'];
$productDescription = $_POST['productDescription'];
$productImage = $_POST['productImage'];
$productPrice = $_POST['productPrice'];



$queryResult=$connect->query("UPDATE `tbl_products` 
                            SET `productName`='$productname',`productPrice`='$productPrice',`ProductDescription`='$productDescription',`productImage`='$productImage' 
                            WHERE productID ='$productid'");

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
