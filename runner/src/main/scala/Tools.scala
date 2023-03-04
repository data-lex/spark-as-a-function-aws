package dp.sparkf

import org.json.JSONObject

import javax.xml.bind.DatatypeConverter
import software.amazon.awssdk.services.cloudwatchlogs.CloudWatchLogsClient
import software.amazon.awssdk.services.cloudwatchlogs.model.{InputLogEvent, PutLogEventsRequest}

object Tools {
  def decodeRequest(payload: String): JSONObject = {
    val decoded = DatatypeConverter.parseHexBinary(payload)
    val text = new String(decoded, "UTF-8")
    new JSONObject(text)
  }

  def updateStatus(message: String, stream: String, token: String): String = {
    val client = CloudWatchLogsClient.builder().build()
    val event = InputLogEvent.builder()
      .message(message)
      .timestamp(System.currentTimeMillis())
      .build()
    val request = PutLogEventsRequest.builder()
      .logEvents(event)
      .logGroupName("/sparkf/api")
      .logStreamName(stream)
      .sequenceToken(token)
      .build()
    val response = client.putLogEvents(request)
    client.close()
    response.nextSequenceToken()
  }
}
