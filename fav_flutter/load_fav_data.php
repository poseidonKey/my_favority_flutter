<?php
if (isset($_GET['category'])) {
  // MySQL 서버 연결 설정
  $servername = "localhost";
  $username = "phpmyadmin";
  $password = "jsy1030";
  $dbname = "test_db";
  $category = $_GET['category'];

  // MySQL 연결 생성
  $conn = new mysqli($servername, $username, $password, $dbname);

  // 연결 확인
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  // 쿼리 작성
  $sql = "SELECT no, name, url, code, alt FROM fav_data  where code='$category'";

  // 쿼리 실행
  $result = $conn->query($sql);

  // 결과가 있는지 확인
  if ($result->num_rows > 0) {
    // 결과를 배열로 저장
    $rows = array();
    while ($row = $result->fetch_assoc()) {
      $rows[] = $row;
    }
    // JSON 형식으로 출력
    header('Content-Type: application/json');
    echo json_encode($rows);
  } else {
    echo "0 results";
  }
  // MySQL 연결 종료
  $conn->close();
} else {
  // 'id' parameter is not set
  echo json_encode(array('error' => 'ID parameter is missing'));
}
