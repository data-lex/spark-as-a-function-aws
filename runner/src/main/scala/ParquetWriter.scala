package dp.sparkf

import org.apache.spark.sql.DataFrame

class ParquetWriter (
  val writeUri: String
) extends BaseWriter {

  override def writeData(df: DataFrame): Unit = {
    df.write.parquet(writeUri)
  }
}
