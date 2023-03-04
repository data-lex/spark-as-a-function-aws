package dp.sparkf

import org.apache.spark.sql.{DataFrame, SparkSession}

object Query {
  def run(df: DataFrame, spark: SparkSession, queryUri: String): DataFrame = {
    val query = spark.sparkContext.wholeTextFiles(queryUri).collect()(0)._2
    df.createOrReplaceTempView("dataset")
    spark.sql(query)
  }
}
