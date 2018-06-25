package dragonBoat.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import dragonBoat.data.DragonBoatActiveInfo;   import dragonBoat.data.DragonBoatAwardInfo;      public class DragonBoatActiveDataAnalyzer extends DataAnalyzer   {                   private var _data:DragonBoatActiveInfo;            private var _dataList:Array;            private var _dataListSelf:Array;            private var _dataListOther:Array;            public function DragonBoatActiveDataAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get data() : DragonBoatActiveInfo { return null; }
            public function get dataList() : Array { return null; }
            public function get dataListSelf() : Array { return null; }
            public function get dataListOther() : Array { return null; }
   }}