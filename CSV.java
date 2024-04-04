import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class CSV {

    public static void main(String[] args) {
        //Denne sti skal ændres til der hvor ens projekt ligger
        String csvFile = "CsvFileReader/src/main/resources/uploads.csv";
        String line;
        String cvsSplitBy = ";";

        List<String> titles = new ArrayList<>();
        List<String> dates = new ArrayList<>();
        List<String> cprs = new ArrayList<>();
        List<String> firstNames = new ArrayList<>();
        List<String> lastNames = new ArrayList<>();
        List<String> streetNames = new ArrayList<>();
        List<String> civicNumbers = new ArrayList<>();
        List<String> zipCodes = new ArrayList<>();
        List<String> city = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {

            while ((line = br.readLine()) != null) {

                String[] data = line.split(cvsSplitBy);

                titles.add(data[0]);
                dates.add(data[1]);
                cprs.add(data[2]);
                firstNames.add(data[3]);
                lastNames.add(data[4]);
                streetNames.add(data[5]);
                civicNumbers.add(data[6]);
                zipCodes.add(data[7]);
                city.add(data[8]);
            }


        } catch (IOException e) {
            e.printStackTrace();
        }

        //SQL
        String host = "localhost"; //host is "localhost" or "127.0.0.1"
        String port = "3306"; //port is where to communicate with the RDBMS
        String database = "newspaper_db"; //database containing tables to be queried
        String cp = "utf8"; //Database codepage supporting Danish (i.e. æøåÆØÅ)
        // Set username and password.
        String username = "root";		// Username for connection
        String password = "Master930bf";	// Password for username

        String url = "jdbc:mysql://" + host + ":" + port + "/" + database + "?characterEncoding=" + cp;

        try {
            // Get a connection.
            Connection connection = DriverManager.getConnection(url, username, password);
            // Create and execute Update.
            Statement statement = connection.createStatement();

            // Loop through all elements
            for (int i = 0; i < cprs.size(); i++) {

                // INSERT JOURNALIST
                //if(/* Journalist doesnt exist. add them and their adress*/)
                statement.executeUpdate("INSERT INTO journalist VALUES('" + cprs.get(i) + "', '" + firstNames.get(i) + "', '" + lastNames.get(i) + "');");
                // INSERT ADDRESS
                statement.executeUpdate("INSERT INTO address VALUES ('" + cprs.get(i) + "', '" + streetNames.get(i) + "', '" + civicNumbers.get(i) + "', '" + city.get(i) + "', '" + zipCodes.get(i) + "', '', 'Denmark');");


                // INSERT PHOTO
                statement.executeUpdate("INSERT INTO photo VALUES ('" + titles.get(i) + "', '" + dates.get(i) + "', '" + cprs.get(i) + "', 'image_data_example');");
            }

            // Close connection.
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
