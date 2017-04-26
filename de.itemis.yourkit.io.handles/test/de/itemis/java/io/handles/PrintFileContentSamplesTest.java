package de.itemis.java.io.handles;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.file.FileAlreadyExistsException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.function.Consumer;

import org.junit.Before;
import org.junit.Test;

public class PrintFileContentSamplesTest {

	private PrintFileContentSamples samples;

	@Before
	public void setup() {
		samples = new PrintFileContentSamples();
	}

	@Test
	public void testJava6() {
		runFileReleasedTest(file -> samples.doJava6(file), "Java 6");
	}

	@Test
	public void testJava6AndCommonsIo() {
		runFileReleasedTest(file -> samples.doApacheCommons(file), "Java 6 Commons Io");
	}

	@Test
	public void testJava7() {
		runFileReleasedTest(file -> samples.doJava7(file), "Java 7");
	}

	@Test
	public void testJava8() {
		runFileReleasedTest(file -> samples.doJava8(file), "Java 8");
	}

	protected void runFileReleasedTest(Consumer<String> printSample, String sampleLabel) {
		String fileName = sampleLabel.trim().replaceAll(" ", "") + ".testData";
		createFile(sampleLabel + " content processed...", fileName);
		printSample.accept(fileName);
		assertDeleteFile(fileName);
	}

	public void assertDeleteFile(String file) {
		try {
			assertTrue(Files.deleteIfExists(Paths.get(file)));
		} catch (Exception e) {
			e.printStackTrace();
			fail(e.getMessage());
		}
	}

	public void createFile(String content, String file) {
		try {
			Files.copy(new ByteArrayInputStream(content.getBytes("UTF-8")), Paths.get(file));
		} catch (FileAlreadyExistsException e1) {
			// e.g. delete failed last time...
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}

}
