package itemActivityGift
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import itemActivityGift.data.ItemEveryDayRecordData;
   import itemActivityGift.model.ItemActivityGiftModel;
   import road7th.comm.PackageIn;
   
   public class ItemActivityGiftManager extends EventDispatcher
   {
      
      private static var _instance:ItemActivityGiftManager;
       
      
      private var _model:ItemActivityGiftModel;
      
      private var frameObj:Object;
      
      private var frameType:int;
      
      private var tipsFrame:BaseAlerFrame;
      
      public function ItemActivityGiftManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : ItemActivityGiftManager
      {
         if(_instance == null)
         {
            _instance = new ItemActivityGiftManager();
         }
         return _instance;
      }
      
      public function get model() : ItemActivityGiftModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new ItemActivityGiftModel();
         SocketManager.Instance.addEventListener("itemActivityGift_data",__itemActivityGiftDataHandler);
      }
      
      private function __itemActivityGiftDataHandler(event:CrazyTankSocketEvent) : void
      {
         var cmd:int = event.pkg.readInt();
         if(cmd == 1)
         {
            everyDayGiftRecordDataHandler(event.pkg);
         }
      }
      
      private function everyDayGiftRecordDataHandler(pkg:PackageIn) : void
      {
         var i:int = 0;
         var dataInfo:* = null;
         var dataDic:Dictionary = new Dictionary();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            dataInfo = new ItemEveryDayRecordData();
            dataInfo.UserID = pkg.readInt();
            dataInfo.TemplateID = pkg.readInt();
            dataInfo.ItemID = pkg.readInt();
            dataInfo.OpenTime = pkg.readDate();
            dataInfo.OpenIndex = pkg.readInt();
            dataDic[dataInfo.TemplateID + "," + dataInfo.ItemID] = dataInfo;
            i++;
         }
         model.itemEveryDayRecord = dataDic;
      }
      
      public function showFrame($frameType:int, $frameObj:Object = null) : void
      {
         var tempItemInfo:* = null;
         var itemEveryDayRecordData:* = null;
         var tempIndex:int = 0;
         var currentTime:* = null;
         var tempStr:* = null;
         var tempArr:* = null;
         var paramStr:* = null;
         frameType = $frameType;
         frameObj = $frameObj;
         if(frameType == 1)
         {
            tempItemInfo = frameObj as InventoryItemInfo;
            itemEveryDayRecordData = ItemActivityGiftManager.instance.model.itemEveryDayRecord[tempItemInfo.TemplateID + "," + tempItemInfo.ItemID];
            tempIndex = 0;
            if(itemEveryDayRecordData)
            {
               tempIndex = itemEveryDayRecordData.OpenIndex;
            }
            else
            {
               tempIndex = 0;
            }
            if(tempIndex > 0)
            {
               currentTime = TimeManager.Instance.Now();
               if(currentTime.getFullYear() == itemEveryDayRecordData.OpenTime.getFullYear() && currentTime.getMonth() == itemEveryDayRecordData.OpenTime.getMonth() && currentTime.getDay() == itemEveryDayRecordData.OpenTime.getDay())
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("itemActivityGift.frame.stepGiftLimit"));
                  return;
               }
            }
            tempStr = ServerConfigManager.instance.getEveryDayOpenPrice[tempIndex];
            tempArr = tempStr.split(",");
            paramStr = "";
            if(tempArr[0] == -300)
            {
               paramStr = tempArr[1] + " " + LanguageMgr.GetTranslation("ddtMoney");
            }
            else if(tempArr[0] == -200)
            {
               paramStr = tempArr[1] + " " + LanguageMgr.GetTranslation("money");
            }
            tipsFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("itemActivityGift.frame.everyDayGiftRecordTxt",tempIndex + 1,paramStr),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
            tipsFrame.addEventListener("response",__onFrameResponse);
         }
      }
      
      private function __onFrameResponse(evt:FrameEvent) : void
      {
         var tempItemInfo:* = null;
         var itemEveryDayRecordData:* = null;
         var tempIndex:int = 0;
         var tempStr:* = null;
         var tempArr:* = null;
         SoundManager.instance.play("008");
         tipsDispose();
         if(!(int(frameType) - 1))
         {
            if(evt.responseCode == 2 || evt.responseCode == 3)
            {
               tempItemInfo = frameObj as InventoryItemInfo;
               itemEveryDayRecordData = ItemActivityGiftManager.instance.model.itemEveryDayRecord[tempItemInfo.TemplateID + "," + tempItemInfo.ItemID];
               tempIndex = 0;
               if(itemEveryDayRecordData)
               {
                  tempIndex = itemEveryDayRecordData.OpenIndex;
               }
               else
               {
                  tempIndex = 0;
               }
               tempStr = ServerConfigManager.instance.getEveryDayOpenPrice[tempIndex];
               tempArr = tempStr.split(",");
               if(tempArr[0] == -300 && PlayerManager.Instance.Self.BandMoney < tempArr[1])
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               }
               else if(tempArr[0] == -200 && PlayerManager.Instance.Self.Money < tempArr[1])
               {
                  LeavePageManager.showFillFrame();
               }
               else
               {
                  SocketManager.Instance.out.sendUseEveryDayGiftRecord(tempItemInfo.TemplateID,tempItemInfo.ItemID,tempIndex + 1);
               }
            }
         }
      }
      
      private function tipsDispose() : void
      {
         if(tipsFrame)
         {
            tipsFrame.removeEventListener("response",__onFrameResponse);
            ObjectUtils.disposeAllChildren(tipsFrame);
            ObjectUtils.disposeObject(tipsFrame);
            tipsFrame = null;
         }
      }
   }
}
