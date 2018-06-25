package vipIntegralShop.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class VipIntegralShopDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _shopInfoVec:Vector.<VipIntegralShopInfo>;
      
      public function VipIntegralShopDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var itemData:* = null;
         _shopInfoVec = new Vector.<VipIntegralShopInfo>();
         var xml:XML = new XML(data);
         var len:int = xml.Item.length();
         var xmllist:XMLList = xml.Item;
         for(i = 0; i < len; )
         {
            itemData = new VipIntegralShopInfo();
            ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
            _shopInfoVec.push(itemData);
            i++;
         }
         onAnalyzeComplete();
      }
      
      public function get shopInfoVec() : Vector.<VipIntegralShopInfo>
      {
         return _shopInfoVec;
      }
   }
}
