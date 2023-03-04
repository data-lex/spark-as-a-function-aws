package dp.sparkf

import org.apache.spark.sql.DataFrame

trait BaseWriter {
  val writeUri: String
  def writeData(df: DataFrame): Unit
}
