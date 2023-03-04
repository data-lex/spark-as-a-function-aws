ThisBuild / version := "0.1.0-SNAPSHOT"

ThisBuild / scalaVersion := "2.12.10"

lazy val root = (project in file("."))
  .settings(
    name := "runner",
    idePackagePrefix := Some("dp.sparkf"),
    libraryDependencies ++= Seq(
      "org.apache.spark" %% "spark-core" % "3.1.3" % Provided,
      "org.apache.spark" %% "spark-sql" % "3.1.3" % Provided,
      "org.apache.hadoop" % "hadoop-aws" % "3.2.0" % Provided,
      "org.json" % "json" % "20220320",
      "software.amazon.awssdk" % "cloudwatchlogs" % "2.17.189"
    )
  )
