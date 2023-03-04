package dp.sparkf

import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.sql.types._

class JsonReader (
  val readUri: String,
  val schemaUri: String
) extends BaseReader {

  override def readData(spark: SparkSession): DataFrame = {
    val schemaFile = spark.sparkContext.wholeTextFiles(schemaUri).collect()(0)._2
    val schemaStruct = DataType.fromJson(schemaFile).asInstanceOf[StructType]
    spark.read.schema(schemaStruct).json(readUri)
  }
}
