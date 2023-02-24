<?php
include('../config.php');
session_start();
$apt_id = $_POST['appoint_id'];
$pat_id = $_POST['patient_id'];

if(isset($_POST['accept_btn']))
{   
    $_SESSION['counter'] = 0;
	$query = $connection->prepare("Update vaccineoffer SET status = '".$_POST['selected-item']."' WHERE patient_id=:pat_id AND appoint_id=:apt_id");
	$query->bindParam("pat_id", $pat_id, PDO::PARAM_INT);
	$query->bindParam("apt_id", $apt_id, PDO::PARAM_INT);
	$query->execute();
    if($query)
    {			
        $_SESSION['status'] = "Updated";
        header('Location: appointmentstatus.php'); 
    }
    else
    {
        $_SESSION['status'] = "Failed";       
        header('Location: appointmentstatus.php'); 
    }    
}

