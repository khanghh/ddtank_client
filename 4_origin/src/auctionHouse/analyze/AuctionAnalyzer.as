package auctionHouse.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   
   public class AuctionAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<AuctionGoodsInfo>;
      
      public var total:int;
      
      public function AuctionAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var info:* = null;
         var xmllistII:* = null;
         var bagInfo:* = null;
         var markInfo:* = null;
         list = new Vector.<AuctionGoodsInfo>();
         var xml:XML = new XML(data);
         var xmllist:XMLList = xml.Item;
         total = xml.@total;
         if(xml.@value == "true")
         {
            for(i = 0; i < xmllist.length(); )
            {
               info = new AuctionGoodsInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               xmllistII = xmllist[i].Item;
               if(xmllistII.length() > 0)
               {
                  bagInfo = new InventoryItemInfo();
                  ObjectUtils.copyPorpertiesByXML(bagInfo,xmllistII[0]);
                  if(bagInfo.BagType != 100)
                  {
                     ItemManager.fill(bagInfo);
                  }
                  else
                  {
                     markInfo = ItemManager.fillByID(bagInfo.TemplateID);
                     bagInfo.Name = markInfo.Name;
                     bagInfo.CategoryID = 74;
                  }
                  info.BagItemInfo = bagInfo;
                  list.push(info);
               }
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
   }
}
