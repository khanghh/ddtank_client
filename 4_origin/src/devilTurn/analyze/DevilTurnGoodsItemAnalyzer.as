package devilTurn.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import devilTurn.model.DevilTurnGoodsItem;
   
   public class DevilTurnGoodsItemAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:Vector.<DevilTurnGoodsItem>;
      
      public function DevilTurnGoodsItemAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var item:* = null;
         var xml:XML = new XML(data);
         _data = new Vector.<DevilTurnGoodsItem>();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               item = new DevilTurnGoodsItem();
               ObjectUtils.copyPorpertiesByXML(item,xmllist[i]);
               _data.push(item);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      public function get data() : Vector.<DevilTurnGoodsItem>
      {
         return _data;
      }
   }
}
