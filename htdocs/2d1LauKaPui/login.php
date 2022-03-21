<?php
//return codes
//0: login successful
//1: connection error;
//2: invalid user data
//3: Invalid Username / Password doesn't match
if ($_POST) {
    $username = $_POST['username'];
    $password = $_POST['password'];

    if ($username && $password) {
        $db_name = '2d1laukapui';
        $db_user = 'root';
        $db_password = '';
        $server_url = 'localhost';
        $mysqli = new mysqli('localhost', $db_user, $db_password, $db_name);

        /* check connection */
        if (mysqli_connect_errno()) {
            die('1'); //"error_message":"'

        } else {

            if ($stmt = $mysqli->prepare("SELECT username FROM loginDB WHERE username = ? and password = ?")) {
                $password = md5($password);
                /* bind parameters for markers */
                $stmt->bind_param("ss", $username, $password);
                /* execute query */
                $stmt->execute();
                /* bind result variables */
                $stmt->bind_result($id);
                /* fetch value */
                $stmt->fetch();
                /* close statement */
                $stmt->close();
            }

            /* close connection */
            $mysqli->close();
            if ($id) {
                //User $username: password match
                echo '0';
            } else {
                //User $username: password doesn't match
                echo '3';
            }

        }

    } else {
        echo '3';
    }
    
} else {
    echo '2';
}
