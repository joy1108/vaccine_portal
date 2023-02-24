<?php
include('../config.php');
$message = '';
$groupmessage = '';
session_start();
include('../include/header.php');

if (isset($_SESSION["username"])) {
    $username = $_SESSION["username"];
	$usertype = $_SESSION['usertype'];
		if ($usertype != "patient"){
		header("location: ../provider/provider.php");
		}	
	
} else {
    session_unset();
    session_write_close();
				header("location: ../index.php"); 
				exit;
}

$query = $connection->prepare("SELECT * FROM patient WHERE user_name=:username");
$query->bindParam("username", $username, PDO::PARAM_STR);
$query->execute();
$result = $query->fetch(PDO::FETCH_ASSOC);
$name = $result["patient_name"];
$id = $result["patient_id"];
$group = $result["group_no"];
$zipCode = $result["patient_zip"];

	if ($group == "") {
		$groupmessage = "Note: The Administrator has not assigned you a group yet";
		}
	else {
		$groupmessage = "You have been assigned group No. ";
	}
// $query5 = $connection->prepare("SELECT patient_id FROM vaccineoffer WHERE patient_id = :id and status = 'completed'");
// $query5->bindParam("id", $id, PDO::PARAM_INT);
// $query5->execute();
// $result5=$query5->fetchAll(PDO::FETCH_OBJ);
// $vaccinedone=$query5->rowCount();
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"/>

<title>Home</title>
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<link rel="stylesheet" type="text/css" href="../css/style.css" />
<link rel="stylesheet" type="text/css" href="../css/app.css" />

<body>
	<?php include '../menus.php'; ?>
	<div class="col-lg-10 col-md-10 col-sm-9 col-xs-12">
		<h4 style="color: white"> Hey There,<strong> <?php echo $name; ?> </h4></strong>
		<hr>
		<div class="stat-panel-number h4" style="color:#90EE90; text-align:left;"><?php echo htmlentities($groupmessage); echo htmlentities($group);?></div>
        <div class="stat-panel-number h4" style="color:#006400; text-align:center;"><?php echo htmlentities($message);?></div>		
		<div class="row" style="padding-left: 110px;">
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-3">
						<div class="panel panel-default">
							<div class="panel-body bk-success text-light">
								<div class="stat-panel text-center">
<?php 
$query2 = $connection->prepare("SELECT patient_id FROM vaccineoffer WHERE patient_id = :id");
$query2->bindParam("id", $id, PDO::PARAM_INT);
$query2->execute();
$result2=$query2->fetchAll(PDO::FETCH_OBJ);
$vaccine_t=$query2->rowCount();
?>
									<div class="stat-panel-number h1 "><?php echo htmlentities($vaccine_t); ?></div>
									<div class="stat-panel-title text-uppercase">Total Matches</div>
								</div>
							</div>											
						</div>
					</div>		
					<div class="col-md-3">
						<div class="panel panel-default">
							<div class="panel-body bk-success text-light">
								<div class="stat-panel text-center">
<?php 
$query3 = $connection->prepare("SELECT patient_id FROM vaccineoffer WHERE patient_id = :id and status = 'pending'");
$query3->bindParam("id", $id, PDO::PARAM_INT);
$query3->execute();
$result3=$query3->fetchAll(PDO::FETCH_OBJ);
$vaccinepending=$query3->rowCount();
?>
									<div class="stat-panel-number h1 "><?php echo htmlentities($vaccinepending); ?></div>
									<div class="stat-panel-title text-uppercase">Current Accommodations</div>
								</div>
							</div>											
						</div>
					</div>													
					<div class="col-md-3">
						<div class="panel panel-default">
							<div class="panel-body bk-primary text-light">
								<div class="stat-panel text-center">
<?php 						
								
	$query4 = $connection->prepare("select distinct (ST_Distance_Sphere(p.patient_location, t2.provider_location)/1000)*0.6213711922 as location, X(t2.provider_location) as prov_loc_x, Y(t2.provider_location) as prov_loc_y
        FROM patient p NATURAL join (
        SELECT patient_id, provider_name, appoint_id, appoint_date, appoint_time, provider_location
		from vaccineappointment natural join provider natural join vaccineoffer
        where status = 'pending' or status = 'accepted') t2
        where p.patient_id = t2.patient_id AND patient_id =:id
        order by ST_Distance_Sphere(p.patient_location, t2.provider_location) LIMIT 1");
	$query4->bindParam("id", $id, PDO::PARAM_INT);
	$query4->execute();
	if ($query4->rowCount() == 0) {
	$closestappointment = "No Offered/Accepted Appointments Yet";
	?><div class="stat-panel-number h6 " style="padding:8px;"><?php echo htmlentities ($closestappointment); ?></div></br><?php 	
	}
	else{
	$result4=$query4->fetch(PDO::FETCH_ASSOC);
	$closestappointment= $result4["location"];
	?></br><div class="stat-panel-number h3" style="padding:7px; margin-top:0px;"><?php echo htmlentities(round($closestappointment, 2));?> Miles </div><?php
	}
	?>
	<script type="text/javascript">var lat = "<?= $result4["prov_loc_x"] ?>";</script>
	<script type="text/javascript">var lng = "<?= $result4["prov_loc_y"] ?>";</script>
	<script type="text/javascript" src="../js/initMap.js"></script>
	
										<div class="stat-panel-title text-uppercase">Appointment Distance</div>
								</div>
							</div>											
						</div>
					</div>							
				</div>
			</div>
		</div>	
		<div class="row"><br>
			<div id="map">
			<script
			  src="https://maps.googleapis.com/maps/api/js?key=''&callback=initMap&v=weekly"
			  async
			></script>
	</div>
	</div>
</body>
</html>