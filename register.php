<?php
  session_start();
  $error = '';
  $success = '';
  include('config.php');
  include "get-coordinates.php";
  
  if (isset($_POST['submit'])) {
  
      $username = $_POST['username'];
      $password = $_POST['password'];
  $usertype = $_POST['usertype'];
      $password_hash = password_hash($password, PASSWORD_BCRYPT);
      $query = $connection->prepare("SELECT * FROM user WHERE user_name=:username");
      $query->bindParam("username", $username, PDO::PARAM_STR);
      $query->execute();
      if ($query->rowCount() > 0) {
    $error = "Username already exists!";
  }
      elseif ($query->rowCount() == 0) {
          $query = $connection->prepare("INSERT INTO user(user_name,passwordhash,user_type) VALUES (:username,:password_hash,:usertype)");
          $query->bindParam("username", $username, PDO::PARAM_STR);
          $query->bindParam("password_hash", $password_hash, PDO::PARAM_STR);
          $query->bindParam("usertype", $usertype, PDO::PARAM_STR);
  
  if ($usertype == 'patient') {
  $patient_name = ($_POST['patient_name']);
  $patient_ssn = ($_POST['patient_ssn']);
  $patient_dob = ($_POST['patient_dob']);
  $patient_phno = ($_POST['patient_phno']);
  $patient_email = ($_POST['patient_email']);
  $patient_street = ($_POST['patient_street']);
  $patient_city = ($_POST['patient_city']);
  $patient_state = ($_POST['patient_state']);
  $patient_zip = ($_POST['patient_zip']);
  $max_travel = ($_POST['max_travel']);
  
  $add = ($patient_street.', '.$patient_city.', '.$patient_state.', '.$patient_zip);
  $coord = getCoordinates($add);
  if ($coord) {
  $lat = $coord['lat'];
  $long = $coord['lng'];
  echo "response received";
  }
  else { 
  $lat = 70;
  $long = 60;
  echo "API error: Used default Values";
  }
  
  $query2 = $connection->prepare("INSERT INTO patient(user_name,patient_name,patient_ssn,patient_dob,
          patient_phno, patient_email, patient_location, patient_street, patient_city, patient_state, patient_zip, max_travel) VALUES (:username,:patient_name,:patient_ssn,:patient_dob,
          :patient_phno, :patient_email, ST_GeomFromText(:patient_location), :patient_street, :patient_city, :patient_state, :patient_zip, :max_travel)");
          $query2->bindParam("username", $username, PDO::PARAM_STR);
  $query2->bindParam("patient_name", $patient_name, PDO::PARAM_STR);
          $query2->bindParam("patient_ssn", $patient_ssn, PDO::PARAM_STR);
          $query2->bindParam("patient_dob", $patient_dob, PDO::PARAM_STR);
          $query2->bindParam("patient_phno", $patient_phno, PDO::PARAM_STR);
          $query2->bindParam("patient_email", $patient_email, PDO::PARAM_STR);
          $query2->bindValue("patient_location", "POINT($lat $long)", PDO::PARAM_STR);			
          $query2->bindParam("patient_street", $patient_street, PDO::PARAM_STR);
          $query2->bindParam("patient_city", $patient_city, PDO::PARAM_STR);
          $query2->bindParam("patient_state", $patient_state, PDO::PARAM_STR);
          $query2->bindParam("patient_zip", $patient_zip, PDO::PARAM_STR);	
          $query2->bindParam("max_travel", $max_travel, PDO::PARAM_INT);	
  
  $query->execute();
          $result2 = $query2->execute();  
  
          if ($result2) {
              $success = "Your registration was successful!";
          } else {
              $error = "Registration Failed";
          }
  }
  if ($usertype == 'provider') {
  $provider_name = ($_POST['provider_name']);
  $provider_type = ($_POST['provider_type']);
  $provider_phno = ($_POST['provider_phno']);
  $provider_email = ($_POST['provider_email']);
  $provider_street = ($_POST['provider_street']);
  $provider_city = ($_POST['provider_city']);
  $provider_state = ($_POST['provider_state']);
  $provider_zip = ($_POST['provider_zip']);
  
  $add = ($provider_street.', '.$provider_city.', '.$provider_state.', '.$provider_zip);
  $coord = getCoordinates($add);
  if ($coord) {
  $lat = $coord['lat'];
  $long = $coord['lng'];
  echo "response received";
  }
  else { 
  $lat = 70;
  $long = 60;
  echo "API error: Used default Values";
  }
  
  $query3 = $connection->prepare("INSERT INTO provider(user_name, provider_name, provider_type, provider_phno, provider_email, provider_location, 
  provider_street, provider_city, provider_state, provider_zip) VALUES (:username, :provider_name, :provider_type, :provider_phno, 
  :provider_email, ST_GeomFromText(:provider_location), :provider_street, :provider_city, :provider_state, :provider_zip)");
          $query3->bindParam("username", $username, PDO::PARAM_STR);
          $query3->bindParam("provider_name", $provider_name, PDO::PARAM_STR);
  $query3->bindParam("provider_type", $provider_type, PDO::PARAM_STR);
          $query3->bindParam("provider_phno", $provider_phno, PDO::PARAM_STR);
          $query3->bindParam("provider_email", $provider_email, PDO::PARAM_STR);
          $query3->bindValue("provider_location", "POINT($lat $long)", PDO::PARAM_STR);			
          $query3->bindParam("provider_street", $provider_street, PDO::PARAM_STR);
          $query3->bindParam("provider_city", $provider_city, PDO::PARAM_STR);
          $query3->bindParam("provider_state", $provider_state, PDO::PARAM_STR);
          $query3->bindParam("provider_zip", $provider_zip, PDO::PARAM_STR);	
  
  $query->execute();
          $result3 = $query3->execute();					
          if ($result3) {
              $success = "Your registration was successful!";
          } else {
              $error = "Registration Failed";
          }
  }		
  }
  }
  ?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Where to Find - Registration</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="./css/app.css" />
  </head>
  <body>
    <div class="container">
      <div class="row card-container">
        <div class="col-md-6 card-container">
          
          <div class="card">
            <p class="logoheader"><img src="./images/icon.png" />Vaccination Panel</p>
            <form action="" method="post">
              <div class="form-group">
                <label for="usertype">Register as:</label>
                <select id = "usertype" class="form-control" name="usertype" required="">
                  <option value="">Select an option</option>
                  <option value="patient">User</option>
                  <option value="provider">Provider</option>
                </select>
              </div>
              <div class="form-group"> 
                <label>Username</label> 
                <input type="text" name="username" class="form-control" required> 
              </div>
              <div class="form-group"> 
                <label>Password</label> 
                <input type="password" name="password" class="form-control" required> 
              </div>
              <div id="patientdetails" style="display:none;" class="form-group">
                <label for="patient_name">Name:</label>
                <input type="text" class="form-control" name="patient_name" placeholder="Enter Name" required><br>
                <label for="patient_ssn">SSN:</label>
                <input type="number" class="form-control" name="patient_ssn" onKeyPress="if(this.value.length==9) return false;" placeholder="Enter SSN" required><br>
                <label for="patient_dob">Date of Birth:</label>
                <input type="date" class="form-control" name="patient_dob" required><br>
                <label for="patient_phno">Phone Number:</label>
                <input type="number" class="form-control" name="patient_phno" onKeyPress="if(this.value.length==10) return false;" placeholder="Enter Phone Number" required><br>
                <label for="patient_email">Email:</label>
                <input type="email" class="form-control" name="patient_email" placeholder="Enter your Email" required><br>
                <label for="patient_street">Street:</label>
                <input type="text" class="form-control" name="patient_street" placeholder="Street" required><br>
                <label for="patient_city">City:</label>
                <input type="text" class="form-control" name="patient_city" placeholder="City" required><br>
                <label for="patient_state">State:</label>
                <input type="text" class="form-control" name="patient_state" placeholder="State" required><br>
                <label for="patient_zip">Zipcode:</label>
                <input type="number" class="form-control" name="patient_zip" onKeyPress="if(this.value.length==5) return false;" placeholder="Zipcode" required></br>
				<label for="max_travel">How Much Are You Willing to Travel? (in Miles):</label>
				<input type="number" class="form-control" name="max_travel" placeholder="Maximum Travel Distance" required></br>
              </div>
              <div id="providerdetails" style="display:none;" class="form-group">
                <label for="provider_name">Name:</label>
                <input type="text" class="form-control" name="provider_name" placeholder="Enter Name" required><br>
                <label for="provider_type">Select Type:</label>
                <select id = "provider_type" class="form-control" name="provider_type" required>
                  <br>
                  <option value="">Select an option</option>
                  <option value="doctor">Doctor</option>
                  <option value="hospital">Hospital</option>
                </select>
                <br>
                <label for="provider_phno">Phone Number:</label>
                <input type="number" class="form-control" name="provider_phno" onKeyPress="if(this.value.length==10) return false;" placeholder="Enter Phone Number" required><br>
                <label for="provider_email">Email:</label>
                <input type="email" class="form-control" name="provider_email" placeholder="Enter your Email" required><br>
                <label for="provider_street">Street:</label>
                <input type="text" class="form-control" name="provider_street" placeholder="Street" required><br>
                <label for="provider_city">City:</label>
                <input type="text" class="form-control" name="provider_city" placeholder="City" required><br>
                <label for="provider_state">State:</label>
                <input type="text" class="form-control" name="provider_state" placeholder="State" required><br>
                <label for="provider_zip">Zipcode:</label>
                <input type="number" class="form-control" name="provider_zip" onKeyPress="if(this.value.length==5) return false;" placeholder="Zipcode" required>
              </div>
              <div style="color:#F00; text-align:center; "><?php echo $error?></div>
              <div style="color:#006400; text-align:center;"><?php echo $success?></div>
              <div class="form-group"> 
                <input type="submit" name="submit" class="btn btn-primary" value="Submit"> 
              </div>
              <div>
                <p>Already Registered? <a href="index.php">Login here</a>.</p>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <script type="text/javascript" src="js/reg.js"></script>
  </body>
</html>