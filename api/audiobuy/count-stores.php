<?php
include 'conn.php'; 
$result=array();
try {
$usertype = $_POST['usertype'];

$queryResult=$connect->query("SELECT COUNT(*) as counts from tbl_customers WHERE usertype = '$usertype'");

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
