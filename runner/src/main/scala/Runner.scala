package dp.sparkf

import org.apache.spark.sql.SparkSession
import scala.util.{Failure, Success, Try}

object Runner {
  def main(args: Array[String]): Unit = {
    val json = Tools.decodeRequest(args(0))
    val stream = json.getString("request_id")
    val token = Tools.updateStatus("PROCESSING", stream, json.getString("token"))

    val run = Try({
      val spark = SparkSession.builder().getOrCreate()
      val source = FileFormat.read(json, spark)
      val result = Query.run(source, spark, json.getString("query_uri"))
      FileFormat.write(json, result)
    })

    run match {
      case Success(_) => Tools.updateStatus("COMPLETED", stream, token)
      case Failure(_) => Tools.updateStatus("FAILED", stream, token)
    }
  }
}
