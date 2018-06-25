package memoryGame.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import memoryGame.data.MemoryGameGoodsInfo;
   
   public class MemoryGameAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<MemoryGameGoodsInfo>;
      
      public function MemoryGameAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         _list = new Vector.<MemoryGameGoodsInfo>();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new MemoryGameGoodsInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _list.push(info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
      
      public function get list() : Vector.<MemoryGameGoodsInfo>
      {
         return _list;
      }
   }
}
