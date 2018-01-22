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
      
      public function BoxTempInfoAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc10_:* = null;
         var _loc9_:int = 0;
         var _loc5_:* = null;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc8_:* = null;
         microendAwardsIDList = [];
         var _loc7_:uint = getTimer();
         var _loc6_:XML = new XML(param1);
         var _loc3_:XMLList = _loc6_..Item;
         inventoryItemList = new DictionaryData();
         caddyTempIDList = new DictionaryData();
         beadTempInfoList = new DictionaryData();
         cityBattleTempInfoList = new DictionaryData();
         caddyBoxGoodsInfo = new Vector.<BoxGoodsTempInfo>();
         _boxTemplateID = BossBoxManager.instance.boxTemplateID;
         exploitTemplateIDs = BossBoxManager.instance.exploitTemplateIDs;
         initDictionaryData();
         if(_loc6_.@value == "true")
         {
            _loc9_ = 0;
            while(_loc9_ < _loc3_.length())
            {
               _loc5_ = _loc3_[_loc9_].@ID;
               _loc2_ = _loc3_[_loc9_].@TemplateId;
               _loc10_ = new BoxGoodsTempInfo();
               ObjectUtils.copyPorpertiesByXML(_loc10_,_loc3_[_loc9_]);
               if(!inventoryItemList.hasKey(_loc5_))
               {
                  inventoryItemList[_loc5_] = [];
               }
               inventoryItemList[_loc5_].push(_loc10_);
               if(_loc5_ == "112376")
               {
                  microendAwardsIDList.push({
                     "count":_loc3_[_loc9_].@ItemCount,
                     "id":int(_loc3_[_loc9_].@TemplateId)
                  });
               }
               if(int(_loc5_) == 112047 || int(_loc5_) == 112222 || int(_loc5_) == 112223 || int(_loc5_) == 112224 || int(_loc5_) == 2000 || int(_loc5_) == 1222010 || int(_loc5_) == 1222110)
               {
                  _loc4_ = new BoxGoodsTempInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc9_]);
                  caddyBoxGoodsInfo.push(_loc4_);
                  caddyTempIDList.add(_loc4_.TemplateId,_loc4_);
               }
               else if(int(_loc5_) == 311500 || int(_loc5_) == 312500 || int(_loc5_) == 313500)
               {
                  _loc8_ = new BoxGoodsTempInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc8_,_loc3_[_loc9_]);
                  beadTempInfoList[_loc5_].push(_loc8_);
               }
               if(int(_loc5_) == 400014 || int(_loc5_) == 400015 || int(_loc5_) == 400016 || int(_loc5_) == 400017 || int(_loc5_) == 400018 || int(_loc5_) == 400019 || int(_loc5_) == 400020)
               {
                  _loc10_ = new BoxGoodsTempInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc10_,_loc3_[_loc9_]);
                  cityBattleTempInfoList[int(_loc5_)].push(_loc10_);
               }
               if(exploitTemplateIDs[_loc5_])
               {
                  _loc10_ = new BoxGoodsTempInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc10_,_loc3_[_loc9_]);
                  exploitTemplateIDs[_loc5_].push(_loc10_);
               }
               _loc9_++;
            }
            MicroendDownloadAwardsManager.getInstance().setup(microendAwardsIDList);
            onAnalyzeComplete();
         }
         else
         {
            message = _loc6_.@message;
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
