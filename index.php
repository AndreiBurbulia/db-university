<?php 

//Define Variable
define("DB_SERVERNAME", "localhost");
define("DB_USERNAME", "root");
define("DB_PASSWORD", "root");
define("DB_NAME", "db_university");

//Conection 

$conn = new mysqli(DB_SERVERNAME, DB_USERNAME, DB_PASSWORD, DB_NAME);


//Check the connection
if ($conn && $conn->connect_error) {
    echo "Connection failed: " . $conn->connect_error;
    die();
}

//Query the database
$sql = "SELECT * FROM departments";
$results = $conn->query($sql);


//Print the value
if ($results && $results->num_rows >0) {
    while ($row = $results->fetch_array()) { ?>
<ul class="box">
    <li>
        <h1><?= $row['name']; ?></h1>
    </li>
    <ul>
        <li>
            <p>Address: <?= $row['address']; ?></p>
        </li>
        <li>
            <p>Phone: <?= $row['phone']; ?></p>
        </li>
        <li>
            <p>Email: <?= $row['email']; ?></p>
        </li>
        <li>
            <p>Website: <?= $row['website']; ?></p>
        </li>
        <li>
            <p>Head of Department: <?= $row['head_of_department']; ?></p>
        </li>
    </ul>
</ul>

<?php
    }
} elseif ($results) {
    echo "nesun risultato";
} else {
    echo "errore nella query";
}


//Close connection
$conn->close();
?>