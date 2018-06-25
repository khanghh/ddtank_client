package store.view.strength.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import store.view.strength.vo.ItemStrengthenGoodsInfo;
   
   public class ItemStrengthenGoodsInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      private var _xml:XML;
      
      public function ItemStrengthenGoodsInfoAnalyzer(onCompleteCall:Function)
      {
         list = new Dictionary();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var itemInfo:* = null;
         _xml = new XML(data);
         list = new Dictionary();
         var xmllist:XMLList = _xml..Item;
         if(_xml.@value == "true")
         {
            for(i = 0; i < xmllist.length(); )
            {
               itemInfo = new ItemStrengthenGoodsInfo();
               ObjectUtils.copyPorpertiesByXML(itemInfo,xmllist[i]);
               list[itemInfo.CurrentEquip + "," + itemInfo.Level] = itemInfo;
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
