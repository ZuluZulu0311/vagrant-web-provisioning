<?php
echo "<h1>Lista de productos</h1>";

$conn = pg_connect("host=192.168.56.51 dbname=productos user=vagrant password=vagrant");

if (!$conn) {
  echo "Error de conexión con la base de datos.";
  exit;
}

$result = pg_query($conn, "SELECT * FROM productos");

if (!$result) {
  echo "Error en la consulta.";
  exit;
}

echo "<ul>";
while ($row = pg_fetch_assoc($result)) {
  echo "<li>{$row['nombre']} - \${$row['precio']}</li>";
}
echo "</ul>";

pg_close($conn);
?>
  