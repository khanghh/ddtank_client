package store.equipGhost.data{   import com.pickgliss.loader.DataAnalyzer;      public final class GhostDataAnalyzer extends DataAnalyzer   {                   private var _dataList:Vector.<GhostData>;            public function GhostDataAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get data() : Vector.<GhostData> { return null; }
   }}