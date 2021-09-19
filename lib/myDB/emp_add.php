<?php
require_once("connection.php");
$action=$_POST["action"];
if($action=="insert"){
    $employeename=$_POST["employeename"];
    $department=$_POST["department"];
    $job=$_POST["job"];
    $dateofbirth=$_POST["dateofbirth"];
    $emplocation=$_POST["emplocation"];
    $phonenumber=$_POST["phonenumber"];
    $nationalnumber=$_POST["nationalnumber"];
    $email=$_POST["email"];
    $sql="SELECT *FROM employee WHERE employeename='$employeename'";
    $query=mysqli_query($connect,$sql);
    $RowCount=mysqli_num_rows($query);
    if($RowCount>=1){
        echo json_encode("EXISTS");
    }
    else{
        //insert
        $sql="INSERT INTO employee (employeename,department,job,dateofbirth,emplocation,phonenumber,nationalnumber,email) VALUES ('$employeename','$department','$job','$dateofbirth','$emplocation','$phonenumber','$nationalnumber','$email')";
        $query=mysqli_query($connect,$sql);
        if($query){
            echo json_encode("INSERTED");
        }
    }
}
else if($action=="getAll"){
    //get list
    $sql="SELECT *FROM employee";
    $query=mysqli_query($connect,$sql);
    $result=array();
    while($row=mysqli_fetch_assoc($query)){
        $result[]=$row;
    }
    echo json_encode($result);
}
else if($action=="update"){
    $id=$_POST["id"];
    $employeename=$_POST["employeename"];
    $department=$_POST["department"];
    $job=$_POST["job"];
    $dateofbirth=$_POST["dateofbirth"];
    $emplocation=$_POST["emplocation"];
    $phonenumber=$_POST["phonenumber"];
    $nationalnumber=$_POST["nationalnumber"];
    $email=$_POST["email"];
    $sql="SELECT *FROM employee WHERE employeename='$employeename'";
    $query=mysqli_query($connect,$sql);
    $RowCount=mysqli_num_rows($query);
    if($RowCount>=1){
        $sql="UPDATE employee SET department='$department',job='$job',dateofbirth='$dateofbirth',emplocation='$emplocation',phonenumber='$phonenumber',nationalnumber='$nationalnumber',email='$email'WHERE id='$id'";
        $query=mysqli_query($connect,$sql);
        if($query){
            echo json_encode("UPDATED");
        }
    }
    else{
        //update with name
        $sql="UPDATE employee SET employeename='$employeename',department='$department',job='$job',dateofbirth='$dateofbirth',emplocation='$emplocation',phonenumber='$phonenumber',nationalnumber='$nationalnumber',email='$email'WHERE id='$id'";
        $query=mysqli_query($connect,$sql);
        if($query){
            echo json_encode("UPDATED");
        }
        
    }
}
else if($action=="delete"){
    $id=$_POST["id"];
        $sql="DELETE FROM employee WHERE id='$id'";
        $query=mysqli_query($connect,$sql);
        if($query){
            echo json_encode("UPDATED");
        }
 }
 else if($action=="register"){
    $empusername = $_POST['empusername'];
	$emppassword = $_POST['emppassword'];

	$sql = "SELECT empusername FROM emplogin WHERE empusername ='$empusername'";

	$result = mysqli_query($connect,$sql);
	$count = mysqli_num_rows($result);

	if ($count == 1) {
		echo json_encode("Error creating account");
	}else{
		$insert = "INSERT INTO emplogin(empusername,emppassword)VALUES('$empusername','$emppassword')";
		$query = mysqli_query($connect,$insert);
		if ($query) {
			echo json_encode("Successfully created account");
		}
	}
 }
 else if($action=="login"){
    $empusername = $_POST['empusername'];
	$emppassword = $_POST['emppassword'];

	$sql = "SELECT empusername FROM emplogin WHERE empusername ='$empusername'AND emppassword ='$emppassword'";

	$result = mysqli_query($connect,$sql);
	$count = mysqli_num_rows($result);

	if ($count >= 1) {
        echo json_encode("Success");	
	}else{
        echo json_encode("Error in login");
    }
 }
?>