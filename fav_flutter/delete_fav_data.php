<?php
if (isset($_GET['no'])) {
  // MySQL 서버 연결 설정
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
  $sql = "delete FROM fav_data  where no='$no'";

  // 쿼리 실행
  $result = $conn->query($sql);

  // MySQL 연결 종료
  $conn->close();
} else {
  // 'id' parameter is not set
  echo json_encode(array('error' => 'ID parameter is missing'));
}
