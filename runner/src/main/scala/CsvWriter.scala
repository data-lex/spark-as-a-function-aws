package dp.sparkf

import org.apache.spark.sql.DataFrame

class CsvWriter (
  val writeUri: String,
  val writeHeader: String,
  val writeDelimiter: String
) extends BaseWriter {

  override def writeData(df: DataFrame): Unit = {
    df.write.options(Map("header" -> writeHeader, "delimiter" -> writeDelimiter)).csv(writeUri)
  }
}
