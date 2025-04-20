package com.group7;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.apache.catalina.Context;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;

public class Main {
    public static void main(String[] args) throws LifecycleException, IOException {
        // Create Tomcat instance
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(8095); // Using port 8095 to avoid conflicts

        // Create temp directory for Tomcat
        File tempDir = Files.createTempDirectory("tomcat-temp").toFile();
        tempDir.deleteOnExit();
        tomcat.setBaseDir(tempDir.getAbsolutePath());

        // Add connector
        tomcat.getConnector();

        // Define base directory
        String webappDirLocation = "src/main/webapp/";
        String webappOutputDir = "target/classes";

        // Define context path
        Context context = tomcat.addWebapp("", new File(webappDirLocation).getAbsolutePath());
        System.out.println("Configuring app with basedir: " + new File(webappDirLocation).getAbsolutePath());

        // Add compiled classes to the context
        File additionWebInfClasses = new File(webappOutputDir);
        WebResourceRoot resources = new StandardRoot(context);
        resources.addPreResources(new DirResourceSet(resources, "/WEB-INF/classes",
                additionWebInfClasses.getAbsolutePath(), "/"));
        context.setResources(resources);

        // Start Tomcat
        tomcat.start();
        System.out.println("Tomcat started on port 8095");
        System.out.println("Open your browser and navigate to http://localhost:8095");
        tomcat.getServer().await();
    }
}
