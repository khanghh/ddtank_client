package feedback.data
{
   public class FeedbackReplyInfo
   {
       
      
      private var _questionId:String;
      
      private var _questionTitle:String;
      
      private var _occurrenceDate:String;
      
      private var _questionContent:String;
      
      private var _replyId:int;
      
      private var _nickName:String;
      
      private var _replyDate:Date;
      
      private var _replyContent:String;
      
      private var _stopReply:String;
      
      public function FeedbackReplyInfo()
      {
         super();
      }
      
      public function get questionId() : String
      {
         return _questionId;
      }
      
      public function set questionId(param1:String) : void
      {
         _questionId = param1;
      }
      
      public function get replyId() : int
      {
         return _replyId;
      }
      
      public function set replyId(param1:int) : void
      {
         _replyId = param1;
      }
      
      public function get nickName() : String
      {
         return _nickName;
      }
      
      public function set nickName(param1:String) : void
      {
         _nickName = param1;
      }
      
      public function get replyDate() : Date
      {
         return _replyDate;
      }
      
      public function set replyDate(param1:Date) : void
      {
         _replyDate = param1;
      }
      
      public function get replyContent() : String
      {
         return _replyContent;
      }
      
      public function set replyContent(param1:String) : void
      {
         _replyContent = param1;
      }
      
      public function get stopReply() : String
      {
         return _stopReply;
      }
      
      public function set stopReply(param1:String) : void
      {
         _stopReply = param1;
      }
      
      public function get questionTitle() : String
      {
         return _questionTitle;
      }
      
      public function set questionTitle(param1:String) : void
      {
         _questionTitle = param1;
      }
      
      public function get occurrenceDate() : String
      {
         return _occurrenceDate;
      }
      
      public function set occurrenceDate(param1:String) : void
      {
         _occurrenceDate = param1;
      }
      
      public function get questionContent() : String
      {
         return _questionContent;
      }
      
      public function set questionContent(param1:String) : void
      {
         _questionContent = param1;
      }
   }
}
