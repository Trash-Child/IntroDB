import java.io.IOException;
import java.util.List;

public class LoaderExample {

	public static void main(String[] args) {
		PhotosAndReportersLoader loader = new PhotosAndReportersLoader();
		try {
			System.out.println("loading from uploads.csv");
			List<PhotoAndReporter> photosAndReporters = loader.loadPhotosAndReporters("uploads.csv");
			for(PhotoAndReporter photoAndReporter : photosAndReporters) {
				System.out.print("\tPhoto: " + photoAndReporter.getPhoto());
				System.out.println("\tReporter: " + photoAndReporter.getReporter());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}


