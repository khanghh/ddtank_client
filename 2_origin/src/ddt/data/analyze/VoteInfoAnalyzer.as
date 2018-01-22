package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.vote.VoteQuestionInfo;
   import ddt.view.vote.VoteInfo;
   import flash.utils.Dictionary;
   
   public class VoteInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var firstQuestionID:String;
      
      public var completeMessage:String;
      
      public var questionLength:int;
      
      public var list:Dictionary;
      
      public var voteId:String;
      
      public var minGrade:int;
      
      public var maxGrade:int;
      
      private var _award:String;
      
      private var _awardDic:Dictionary;
      
      public function VoteInfoAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      public function get awardDic() : Dictionary
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         if(_award == "")
         {
            return null;
         }
         var _loc2_:Array = _award.split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = _loc2_[_loc3_].split("|");
            if(_loc1_)
            {
               _awardDic[_loc1_[0]] = _loc1_[1];
            }
            _loc3_++;
         }
         return _awardDic;
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         _awardDic = new Dictionary();
         list = new Dictionary();
         var _loc5_:XML = new XML(param1);
         voteId = _loc5_.@voteId;
         firstQuestionID = _loc5_.@firstQuestionID;
         completeMessage = _loc5_.@completeMessage;
         minGrade = _loc5_.@minGrade;
         maxGrade = _loc5_.@maxGrade;
         _award = _loc5_.@award;
         var _loc4_:XMLList = _loc5_..item;
         questionLength = _loc4_.length();
         _loc8_ = 0;
         while(_loc8_ < _loc4_.length())
         {
            _loc7_ = new VoteQuestionInfo();
            _loc7_.questionID = _loc4_[_loc8_].@id;
            _loc7_.multiple = _loc4_[_loc8_].@multiple == "true"?true:false;
            _loc7_.otherSelect = _loc4_[_loc8_].@otherSelect == "true"?true:false;
            _loc7_.question = _loc4_[_loc8_].@question;
            _loc7_.nextQuestionID = _loc4_[_loc8_].@nextQuestionID;
            _loc7_.questionType = _loc4_[_loc8_].@questionType;
            _loc2_ = _loc4_[_loc8_]..answer;
            _loc7_.answerLength = _loc2_.length();
            _loc6_ = 0;
            while(_loc6_ < _loc2_.length())
            {
               _loc3_ = new VoteInfo();
               _loc3_.answerId = _loc2_[_loc6_].@id;
               _loc3_.answer = _loc2_[_loc6_].@value;
               _loc7_.answer.push(_loc3_);
               _loc6_++;
            }
            list[_loc7_.questionID] = _loc7_;
            _loc8_++;
         }
         onAnalyzeComplete();
      }
   }
}
