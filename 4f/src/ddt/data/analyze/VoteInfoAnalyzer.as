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
      
      public function VoteInfoAnalyzer(param1:Function){super(null);}
      
      public function get awardDic() : Dictionary{return null;}
      
      override public function analyze(param1:*) : void{}
   }
}
