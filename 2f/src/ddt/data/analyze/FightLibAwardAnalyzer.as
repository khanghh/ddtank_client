package ddt.data.analyze{   import com.pickgliss.loader.DataAnalyzer;   import ddt.data.fightLib.FightLibAwardInfo;      public class FightLibAwardAnalyzer extends DataAnalyzer   {                   public var list:Array;            public function FightLibAwardAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            private function sortItems(items:Array) : void { }
            private function pushInListByIDAndDiff(item:Object, id:int, diff:int) : void { }
            private function findAwardInfoByID(id:int) : FightLibAwardInfo { return null; }
   }}