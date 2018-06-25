package feedback.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import feedback.data.FeedbackReplyInfo;
   import road7th.data.DictionaryData;
   
   public class LoadFeedbackReplyAnalyzer extends DataAnalyzer
   {
       
      
      public var listData:DictionaryData;
      
      public function LoadFeedbackReplyAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var feedbackReplyInfo:* = null;
         trace("feedbackReplyInfo:",XML(data)..Question);
         if(String(data) != "0" || !data)
         {
            listData = new DictionaryData();
            xmllist = XML(data)..Question;
            if(xmllist)
            {
               for(i = 0; i < xmllist.length(); )
               {
                  feedbackReplyInfo = new FeedbackReplyInfo();
                  feedbackReplyInfo.questionId = xmllist[i].@QuestionID;
                  feedbackReplyInfo.replyId = xmllist[i].@ReplyID;
                  feedbackReplyInfo.occurrenceDate = xmllist[i].@OccurrenceDate;
                  feedbackReplyInfo.questionTitle = xmllist[i].@Title;
                  feedbackReplyInfo.questionContent = xmllist[i].@QuestionContent;
                  feedbackReplyInfo.replyContent = xmllist[i].@ReplyContent;
                  feedbackReplyInfo.stopReply = xmllist[i].@StopReply;
                  listData.add(feedbackReplyInfo.questionId + "_" + feedbackReplyInfo.replyId,feedbackReplyInfo);
                  i++;
               }
            }
         }
         onAnalyzeComplete();
      }
   }
}
