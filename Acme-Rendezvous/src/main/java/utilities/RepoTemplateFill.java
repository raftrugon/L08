
package utilities;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class RepoTemplateFill {

	public static void main(final String[] args) throws UnsupportedEncodingException, IOException {
		File[] files = new File("src/main/java/domain").listFiles();
		String repoUrl = "src/main/java/repositories";
		String repoTemplate = "src/main/resources/Templates/repositoryTemplate.txt";
		String serviceUrl = "src/main/java/services";
		String serviceTemplate = "src/main/resources/Templates/serviceTemplate.txt";
		String converterUrl = "src/main/java/converters";
		String converter1Template = "src/main/resources/Templates/converter1Template.txt";
		String converter2Template = "src/main/resources/Templates/converter2Template.txt";

		for (File file : files)
			if (file.isFile()) {
				String fileName = file.getName();
				int pos = fileName.lastIndexOf(".");
				String entity = fileName.substring(0, pos);
				String subEntity = Character.toLowerCase(entity.charAt(0)) + entity.substring(1);
				//Repositories
				String repoString = new String(Files.readAllBytes(Paths.get(repoTemplate)), "UTF-8");
				repoString = repoString.replace("%ent%", entity);

				PrintWriter prRepo = new PrintWriter(repoUrl + "/" + entity + "Repository.java");
				prRepo.print(repoString);
				prRepo.close();

				//Converters
				String converter1String = new String(Files.readAllBytes(Paths.get(converter1Template)), "UTF-8");
				converter1String = converter1String.replace("%ea%", subEntity);
				converter1String = converter1String.replace("%ent%", entity);

				String converter2String = new String(Files.readAllBytes(Paths.get(converter2Template)), "UTF-8");
				converter2String = converter2String.replace("%ea%", subEntity);
				converter2String = converter2String.replace("%ent%", entity);

				PrintWriter prConverter1 = new PrintWriter(converterUrl + "/" + entity + "ToStringConverter.java");
				PrintWriter prConverter2 = new PrintWriter(converterUrl + "/StringTo" + entity + "Converter.java");
				prConverter1.print(converter1String);
				prConverter1.close();
				prConverter2.print(converter2String);
				prConverter2.close();

				//Services
				String serviceString = new String(Files.readAllBytes(Paths.get(serviceTemplate)), "UTF-8");
				serviceString = serviceString.replace("%ea%", subEntity);
				serviceString = serviceString.replace("%ent%", entity);

				PrintWriter prService = new PrintWriter(serviceUrl + "/" + entity + "Service.java");
				prService.print(serviceString);
				prService.close();
			}
	}
}
