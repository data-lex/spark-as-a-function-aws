package dp.sparkf

import org.apache.spark.sql.{DataFrame, SparkSession}
import org.json.JSONObject

object FileFormat {
  def read(json: JSONObject, spark: SparkSession): DataFrame = {
    val readFormat = json.getString("read_format")
    readFormat match {
      case "csv" =>
        new CsvReader(
          readUri = json.getString("read_uri"),
          readHeader = json.getString("read_header"),
          readDelimiter = json.getString("read_delimiter")
        ).readData(spark)
      case "json" =>
        new JsonReader(
          readUri = json.getString("read_uri"),
          schemaUri = json.getString("schema_uri")
        ).readData(spark)
      case "parquet" =>
        new ParquetReader(
          readUri = json.getString("read_uri")
        ).readData(spark)
    }
  }

  def write(json: JSONObject, df: DataFrame): Unit = {
    val writeFormat = json.getString("write_format")
    val uri = s"s3a://sparkf.output/${json.getString("request_id")}"
    writeFormat match {
      case "csv" =>
        new CsvWriter(
          writeUri = uri,
          writeHeader = json.getString("write_header"),
          writeDelimiter = json.getString("write_delimiter")
        ).writeData(df)
      case "parquet" =>
        new ParquetWriter(
          writeUri = uri
        ).writeData(df)
    }
  }
}
