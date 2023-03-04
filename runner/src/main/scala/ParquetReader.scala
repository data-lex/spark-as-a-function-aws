package dp.sparkf
import org.apache.spark.sql.{DataFrame, SparkSession}

class ParquetReader (
  val readUri: String
) extends BaseReader {

  override def readData(spark: SparkSession): DataFrame = {
    spark.read.parquet(readUri)
  }
}
