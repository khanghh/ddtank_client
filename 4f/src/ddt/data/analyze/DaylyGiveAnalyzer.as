package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.DaylyGiveInfo;
   import flash.utils.Dictionary;
   
   public class DaylyGiveAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public var signAwardList:Array;
      
      public var signAwardCounts:Array;
      
      public var userAwardLog:int;
      
      public var awardLen:int;
      
      private var _xml:XML;
      
      private var _awardDic:Dictionary;
      
      public var signPetInfo:Array;
      
      public function DaylyGiveAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
