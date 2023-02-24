<?php
session_start();
include ('config.php');
$error = '';
$success = '';
if (!isset($_SESSION["username"]))
{
    if (isset($_POST['submit']))
    {
        $username = $_POST['username'];
        $password = $_POST['password'];
        $query = $connection->prepare("SELECT * FROM user WHERE user_name=:username");
        $query->bindParam("username", $username, PDO::PARAM_STR);
        $query->execute();
        $result = $query->fetch(PDO::FETCH_ASSOC);
        if (!$result)
        {
            $error = "Wrong Username and Password Combination";
        }
        else
        {
            if (password_verify($password, $result['passwordhash']))
            {
                $_SESSION['username'] = $result['user_name'];
                $_SESSION['usertype'] = $result['user_type'];
                $success = "Login was successful!";
                if ($result['user_type'] == 'patient')
                {
                    header("location: ./patient/patient.php");
                    exit;
                }
                elseif ($result['user_type'] == 'provider')
                {
                    header("location: ./provider/provider.php");
                    exit;
                }

            }
            else
            {
                $error = "Wrong Username and Password Combination";
            }
        }
    }
}
else
{
    header("location: index.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="./css/style.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/app.css" />
  </head>
  <body>
    <div class="container">
      <div class="row card-container" >
        <div class="col-md-6">
          <div style="color:#006400;"><?php echo $success?></div>
          <div class="card">
            <p class="logoheader"><img src="./images/icon.png" />Vaccination Panel</p>
            <h2>Login with your username and password</h2>
            <div class="col-md-12 loginForm">
              <form action="" method="post">
                <div class="form-group"> 
                  <label>Username</label> 
                  <input type="text" name="username" class="form-control" required /> 
                </div>
                <div class="form-group"> 
                  <label>Password</label> 
                  <input type="password" name="password" class="form-control" required> 
                </div>
                <div style="color:#F00;"><?php echo $error?></div>
                <div class="form-group"> 
                  <input type="submit" name="submit" class="btn btn-primary" value="Submit"> 
                </div>
                <p>Don't have an account? <a href="register.php">Register here</a>.</p>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>