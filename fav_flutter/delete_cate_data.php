<?php

if (isset($_GET['no'])) {

  // Assuming you have established a MySQL connection
  $servername = "localhost";
  $username = "phpmyadmin";
  $password = "jsy1030";
  $dbname = "test_db";
  $no = $_GET['no'];


  // MySQL 연결 생성
  $conn = new mysqli($servername, $username, $password, $dbname);

  // 연결 확인
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  // 쿼리 작성
  $sql = "SELECT * FROM fav_category WHERE fa_no = '$no' ";

  // 쿼리 실행
  $result = $conn->query($sql);
  if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $code = $row['fa_code'];
    echo "$code";
  } else {
    echo "<br>No code found for the provided ID";
    exit();
  }

  $sql_delete_data = "DELETE FROM fav_data WHERE code = '$code'";

  if ($conn->query($sql_delete_data) === TRUE) {
    echo "Data associated with code '$code' deleted successfully from data table";
  } else {
    echo "Error deleting data: " . $conn->error;
    exit();
  }
  // // 3. Delete the record from the category table
  $sql_delete_category = "DELETE FROM fav_category WHERE fa_no = '$no' ";

  if ($conn->query($sql_delete_category) === TRUE) {
    echo "Record deleted successfully from category table";
  } else {
    echo "Error deleting record: " . $conn->error;
  }

  // MySQL 연결 종료
  $conn->close();
  echo "<br>success";
} else {
  // 'id' parameter is not set
  echo json_encode(array('error' => 'ID parameter is missing'));
}
