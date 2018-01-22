package feedback.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import feedback.data.FeedbackReplyInfo;
   import road7th.data.DictionaryData;
   
   public class LoadFeedbackReplyAnalyzer extends DataAnalyzer
   {
       
      
      public var listData:DictionaryData;
      
      public function LoadFeedbackReplyAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         trace("feedbackReplyInfo:",XML(param1)..Question);
         if(String(param1) != "0" || !param1)
         {
            listData = new DictionaryData();
            _loc3_ = XML(param1)..Question;
            if(_loc3_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length())
               {
                  _loc2_ = new FeedbackReplyInfo();
                  _loc2_.questionId = _loc3_[_loc4_].@QuestionID;
                  _loc2_.replyId = _loc3_[_loc4_].@ReplyID;
                  _loc2_.occurrenceDate = _loc3_[_loc4_].@OccurrenceDate;
                  _loc2_.questionTitle = _loc3_[_loc4_].@Title;
                  _loc2_.questionContent = _loc3_[_loc4_].@QuestionContent;
                  _loc2_.replyContent = _loc3_[_loc4_].@ReplyContent;
                  _loc2_.stopReply = _loc3_[_loc4_].@StopReply;
                  listData.add(_loc2_.questionId + "_" + _loc2_.replyId,_loc2_);
                  _loc4_++;
               }
            }
         }
         onAnalyzeComplete();
      }
   }
}
