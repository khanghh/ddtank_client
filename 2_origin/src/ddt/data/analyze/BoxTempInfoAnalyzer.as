package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.manager.BossBoxManager;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import microenddownload.MicroendDownloadAwardsManager;
   import road7th.data.DictionaryData;
   
   public class BoxTempInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var inventoryItemList:DictionaryData;
      
      private var _boxTemplateID:Dictionary;
      
      public var caddyBoxGoodsInfo:Vector.<BoxGoodsTempInfo>;
      
      public var caddyTempIDList:DictionaryData;
      
      public var beadTempInfoList:DictionaryData;
      
      public var cityBattleTempInfoList:DictionaryData;
      
      public var exploitTemplateIDs:Dictionary;
      
      private var microendAwardsIDList:Array;
      
      public function BoxTempInfoAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var info:* = null;
         var i:int = 0;
         var boxTempID:* = null;
         var templateId:int = 0;
         var info1:* = null;
         var info2:* = null;
         microendAwardsIDList = [];
         var _start:uint = getTimer();
         var xml:XML = new XML(data);
         var items:XMLList = xml..Item;
         inventoryItemList = new DictionaryData();
         caddyTempIDList = new DictionaryData();
         beadTempInfoList = new DictionaryData();
         cityBattleTempInfoList = new DictionaryData();
         caddyBoxGoodsInfo = new Vector.<BoxGoodsTempInfo>();
         _boxTemplateID = BossBoxManager.instance.boxTemplateID;
         exploitTemplateIDs = BossBoxManager.instance.exploitTemplateIDs;
         initDictionaryData();
         if(xml.@value == "true")
         {
            for(i = 0; i < items.length(); )
            {
               boxTempID = items[i].@ID;
               templateId = items[i].@TemplateId;
               info = new BoxGoodsTempInfo();
               ObjectUtils.copyPorpertiesByXML(info,items[i]);
               if(!inventoryItemList.hasKey(boxTempID))
               {
                  inventoryItemList[boxTempID] = [];
               }
               inventoryItemList[boxTempID].push(info);
               if(boxTempID == "112376")
               {
                  microendAwardsIDList.push({
                     "count":items[i].@ItemCount,
                     "id":int(items[i].@TemplateId)
                  });
               }
               if(int(boxTempID) == 112047 || int(boxTempID) == 112222 || int(boxTempID) == 112223 || int(boxTempID) == 112224 || int(boxTempID) == 2000 || int(boxTempID) == 1222010 || int(boxTempID) == 1222110)
               {
                  info1 = new BoxGoodsTempInfo();
                  ObjectUtils.copyPorpertiesByXML(info1,items[i]);
                  caddyBoxGoodsInfo.push(info1);
                  caddyTempIDList.add(info1.TemplateId,info1);
               }
               else if(int(boxTempID) == 311500 || int(boxTempID) == 312500 || int(boxTempID) == 313500)
               {
                  info2 = new BoxGoodsTempInfo();
                  ObjectUtils.copyPorpertiesByXML(info2,items[i]);
                  beadTempInfoList[boxTempID].push(info2);
               }
               if(int(boxTempID) == 400014 || int(boxTempID) == 400015 || int(boxTempID) == 400016 || int(boxTempID) == 400017 || int(boxTempID) == 400018 || int(boxTempID) == 400019 || int(boxTempID) == 400020)
               {
                  info = new BoxGoodsTempInfo();
                  ObjectUtils.copyPorpertiesByXML(info,items[i]);
                  cityBattleTempInfoList[int(boxTempID)].push(info);
               }
               if(exploitTemplateIDs[boxTempID])
               {
                  info = new BoxGoodsTempInfo();
                  ObjectUtils.copyPorpertiesByXML(info,items[i]);
                  exploitTemplateIDs[boxTempID].push(info);
               }
               i++;
            }
            MicroendDownloadAwardsManager.getInstance().setup(microendAwardsIDList);
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      private function initDictionaryData() : void
      {
         beadTempInfoList.add(311500,new Vector.<BoxGoodsTempInfo>());
         beadTempInfoList.add(312500,new Vector.<BoxGoodsTempInfo>());
         beadTempInfoList.add(313500,new Vector.<BoxGoodsTempInfo>());
         cityBattleTempInfoList.add(400014,new Vector.<BoxGoodsTempInfo>());
         cityBattleTempInfoList.add(400015,new Vector.<BoxGoodsTempInfo>());
         cityBattleTempInfoList.add(400016,new Vector.<BoxGoodsTempInfo>());
         cityBattleTempInfoList.add(400017,new Vector.<BoxGoodsTempInfo>());
         cityBattleTempInfoList.add(400018,new Vector.<BoxGoodsTempInfo>());
         cityBattleTempInfoList.add(400019,new Vector.<BoxGoodsTempInfo>());
         cityBattleTempInfoList.add(400020,new Vector.<BoxGoodsTempInfo>());
      }
   }
}
