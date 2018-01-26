package memoryGame.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import memoryGame.data.MemoryGameGoodsInfo;
   
   public class MemoryGameAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<MemoryGameGoodsInfo>;
      
      public function MemoryGameAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Vector.<MemoryGameGoodsInfo>{return null;}
   }
}
