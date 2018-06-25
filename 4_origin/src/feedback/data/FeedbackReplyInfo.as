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
      
      public function set questionId(value:String) : void
      {
         _questionId = value;
      }
      
      public function get replyId() : int
      {
         return _replyId;
      }
      
      public function set replyId(value:int) : void
      {
         _replyId = value;
      }
      
      public function get nickName() : String
      {
         return _nickName;
      }
      
      public function set nickName(value:String) : void
      {
         _nickName = value;
      }
      
      public function get replyDate() : Date
      {
         return _replyDate;
      }
      
      public function set replyDate(value:Date) : void
      {
         _replyDate = value;
      }
      
      public function get replyContent() : String
      {
         return _replyContent;
      }
      
      public function set replyContent(value:String) : void
      {
         _replyContent = value;
      }
      
      public function get stopReply() : String
      {
         return _stopReply;
      }
      
      public function set stopReply(value:String) : void
      {
         _stopReply = value;
      }
      
      public function get questionTitle() : String
      {
         return _questionTitle;
      }
      
      public function set questionTitle(value:String) : void
      {
         _questionTitle = value;
      }
      
      public function get occurrenceDate() : String
      {
         return _occurrenceDate;
      }
      
      public function set occurrenceDate(value:String) : void
      {
         _occurrenceDate = value;
      }
      
      public function get questionContent() : String
      {
         return _questionContent;
      }
      
      public function set questionContent(value:String) : void
      {
         _questionContent = value;
      }
   }
}
