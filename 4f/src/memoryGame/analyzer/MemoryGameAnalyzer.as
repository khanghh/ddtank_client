package memoryGame.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import memoryGame.data.MemoryGameGoodsInfo;      public class MemoryGameAnalyzer extends DataAnalyzer   {                   private var _list:Vector.<MemoryGameGoodsInfo>;            public function MemoryGameAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get list() : Vector.<MemoryGameGoodsInfo> { return null; }
   }}