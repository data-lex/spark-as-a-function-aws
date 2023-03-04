package dp.sparkf

import org.apache.spark.sql.{DataFrame, SparkSession}

class CsvReader (
  val readUri: String,
  val readHeader: String,
  val readDelimiter: String
) extends BaseReader {

  override def readData(spark: SparkSession): DataFrame = {
    spark.read.options(Map("header"-> readHeader, "delimiter" -> readDelimiter)).csv(readUri)
  }
}
