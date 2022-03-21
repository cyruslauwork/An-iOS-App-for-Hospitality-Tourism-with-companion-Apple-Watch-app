<?php
//return codes:
//0: sign up successfully
//1: connection error
//2: invalid username / data
//3: Username exists
//4: passwords do not match
if ($_POST) {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $c_password = $_POST['c_password'];

    if ($_POST['username']) {
        if ($password == $c_password) {
            $db_name = '2d1laukapui';
            $db_user = 'root';
            $db_password = '';
            $server_url = 'localhost';
            $mysqli = new mysqli('localhost', $db_user, $db_password, $db_name);

            /* check connection */
            if (mysqli_connect_errno()) {
                //"Connect failed
                echo '1';
            } else {
                $stmt = $mysqli->prepare("INSERT INTO loginDB (username, password) VALUES (?, ?)");
                $password = md5($password);
                $stmt->bind_param('ss', $username, $password);
                /* execute prepared statement */
                $stmt->execute();
                $success = $stmt->affected_rows;
                /* close statement and connection */
                $stmt->close();
                /* close connection */
                $mysqli->close();
                if ($success > 0) {
                    //User created sucessfully
                    echo '0';
                } else {
                    //Username Exists
                    echo '3';
                }
            }
        } else {
            //Passwords does not match
            echo '4';
        }
    } else {
        //invalid username
        echo '2';
    }
} else {
    //Invalid Data
    echo '2';
}
