package dp.sparkf

import org.apache.spark.sql.{DataFrame, SparkSession}

trait BaseReader {
  val readUri: String
  def readData(spark: SparkSession): DataFrame
}
