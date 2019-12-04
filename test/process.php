<!DOCTYPE html>
<html>

<head>
</head>

<body>
  <div style="border:1px solid red;">
    <table>
      <?php
      print "<tr>
                <th>Όνομα:</th><td>" . $_GET['Name'] . "</td>
              </tr>";
      print "<tr>
                <th>Επώνυμο:</th><td>" . $_GET['Surname'] . "</td>
              </tr>";
      print "<tr>
                <th>Φύλο:</th><td>" . $_GET['gender'] . "</td>
              </tr>";
      $fp = fopen('test.dat', 'w');
      fprintf($fp, "%s\n", $_GET['Name'] . "\n");
      fprintf($fp, "%s\n", $_GET['Surname'] . "\n");
      fprintf($fp, "%s\n", $_GET['gender'] . "\n");
      fclose($fp);
      ?>
    </table>
  </div>
</body>

</html>