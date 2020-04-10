<?php
$databases['default']['default'] = array (
   'database' => getenv('MYSQL_DATABASE'),
   'username' => getenv('MYSQL_USER'),
   'password' => getenv('MYSQL_PASSWORD'),
   'host' => getenv('MYSQL_HOST'),
   'port' => getenv('MYSQL_PORT'),
   'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
   'driver' => 'mysql',
   'prefix' => '',
   'collation' => 'utf8mb4_general_ci',
);
$settings['hash_salt'] = json_encode($databases);

if ( (!array_key_exists('HTTPS', $_SERVER)) && (PHP_SAPI !== 'cli') ) {
  $new_url = $_SERVER['HTTP_HOST'];
  $new_url .= $_SERVER['REQUEST_URI'];

  header('HTTP/1.1 301 Moved Permanently');
  header('Location: https://'. $new_url);
  exit();
}
