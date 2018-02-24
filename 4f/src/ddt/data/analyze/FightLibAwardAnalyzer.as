package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.fightLib.FightLibAwardInfo;
   
   public class FightLibAwardAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function FightLibAwardAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      private function sortItems(param1:Array) : void{}
      
      private function pushInListByIDAndDiff(param1:Object, param2:int, param3:int) : void{}
      
      private function findAwardInfoByID(param1:int) : FightLibAwardInfo{return null;}
   }
}
