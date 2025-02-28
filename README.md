# spring-cicd
1. Download JDK21 

	https://www.openlogic.com/openjdk-downloads

	Check java version >>java -version
2. Download Gradle (Binary-only)

	https://gradle.org/install/
3. Create a folder in C drive and extract those files, `C:/Gradle/gradle-8.12`
4. Paste below path in env variables under path 

	`C:\Gradle\gradle-8.12\bin`

	Check gradle version `>>gradle -v`
5. Download and install Intellij Idea (Community edition)

	https://www.jetbrains.com/idea/download
6. Create spring application from here https://start.spring.io/index.html
 ```Project - Gradle-groovy
	Language - Java
	Spring boot - 3.4.1
	Group - com.ust
	Artifact - springShopping
	Packaging - jar
	Java - 21 ```
7. Click on Add Dependencies, search for web, add spring web dependency
8. Click on Generate, project will be downloaded into you local machine
9. Extract the comprised file and open it in Intellij, Wait till all imports are done
10. Under main/java/com/ust/springShopping go to main method click on run play button and see no errors in the logs
11. Create a sample controller for testing. (localhost:8080/get) -->"Welcome to Spring Shopping App" 
12. Create a new project in devOps "spring-shopping"
13. Under repos, copy the clone url and clone in your local machine 
14. Copy all the project files in the git folder.
15. Go to build.gradle file and change the version to latest from snapshot-0.0.1
16. Go to Terminal and build the project with gradle command `>>gradle build`
17. Create a Docker file and add below contents. Change jar file name
	```FROM openjdk:21
	EXPOSE 8080
	ADD build/libs/springShopping-latest.jar springShopping-latest.jar
	ENTRYPOINT ["java","-jar","/springShopping-latest.jar"] ```
18. Push the changes to azure git

	```>>cd spring-shopping
	>>git add .
	>>git commit -m "message"
	>>git push```
19. Open azure portal and create azure container registry - springshoppingreg
20. Create Azure Kubernetes Service, while create under integration mention above container registry
21. Add deployment file in the root and push to git 
22. Go to azure devOps, Repos - click on setup build
23. Select Docker with azure container registry, then select registry from dropdown
24. Change the tag to "latest" in the variables section
25. Below tasks should be in the same order from the starting.
	Add new task from assistence, Java Tool Installer, add jdk21, x64, Preinstalled
26. Same way add Gradle, uncheck on publish junits results
27. Add copy files with below details

	```source - $(Build.SourcesDirectory)/build/libs
	content - **/*.jar
	target - $(Build.ArtifactStagingDirectory)
	Advanced->check on overwrite```
28. Docker task was already added, now under that add below tasks
29. Add copyfiles task

	```source - $(Build.SourcesDirectory)
	content - **/deployment.yml
	target - $(Build.ArtifactStagingDirectory)
	Advanced -> check on overwrite```
30. Add publish build artifacts task
31. Save and run the pipeline
32. Once it's get successed, Go to registry and under services go to repositories and check the artifact was added or not
33. Now update the deployment file with the registry and repo details and push the changes
34. DevOps, go to releases, create new pipeline
35. Select 'Deploy to Kubernetes cluster' and add stage name
36. Add artifact build and enable continues deployment trigger
37. Click on `1job,1task`, click on Kubectl and create a new service connection with the new cluster and registry created earlier.
38. Select the newly created service connection from the dropdown
39. Select the Kubectl command as `apply`
40. Check on configuration file, select the deployment file by clicking on 3 dots (...)
41. Save the pipeline and create release.
42. Click on release link and then click on deploy to start the deployment
43. Upon successful deployment,go to kubernetes, under kubernetes resources go to run command
	```>>kubectl get deployments
	>>kubectl get pods
	>>kubectl get svc```
44. Take the external ip address and hit the browser with 80 port with `/get` endpoint
	

	
	
