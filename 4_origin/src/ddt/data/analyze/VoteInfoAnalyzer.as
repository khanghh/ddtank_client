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
      
      public function VoteInfoAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      public function get awardDic() : Dictionary
      {
         var i:int = 0;
         var temp:* = null;
         if(_award == "")
         {
            return null;
         }
         var awardArr:Array = _award.split(",");
         for(i = 0; i < awardArr.length; )
         {
            temp = awardArr[i].split("|");
            if(temp)
            {
               _awardDic[temp[0]] = temp[1];
            }
            i++;
         }
         return _awardDic;
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var info:* = null;
         var answerList:* = null;
         var j:int = 0;
         var voteInfo:* = null;
         _awardDic = new Dictionary();
         list = new Dictionary();
         var xml:XML = new XML(data);
         voteId = xml.@voteId;
         firstQuestionID = xml.@firstQuestionID;
         completeMessage = xml.@completeMessage;
         minGrade = xml.@minGrade;
         maxGrade = xml.@maxGrade;
         _award = xml.@award;
         var itemList:XMLList = xml..item;
         questionLength = itemList.length();
         for(i = 0; i < itemList.length(); )
         {
            info = new VoteQuestionInfo();
            info.questionID = itemList[i].@id;
            info.multiple = itemList[i].@multiple == "true"?true:false;
            info.otherSelect = itemList[i].@otherSelect == "true"?true:false;
            info.question = itemList[i].@question;
            info.nextQuestionID = itemList[i].@nextQuestionID;
            info.questionType = itemList[i].@questionType;
            answerList = itemList[i]..answer;
            info.answerLength = answerList.length();
            for(j = 0; j < answerList.length(); )
            {
               voteInfo = new VoteInfo();
               voteInfo.answerId = answerList[j].@id;
               voteInfo.answer = answerList[j].@value;
               info.answer.push(voteInfo);
               j++;
            }
            list[info.questionID] = info;
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
