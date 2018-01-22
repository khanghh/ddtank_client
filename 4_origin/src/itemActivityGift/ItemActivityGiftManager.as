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
      
      public function ItemActivityGiftManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
      
      private function __itemActivityGiftDataHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         if(_loc2_ == 1)
         {
            everyDayGiftRecordDataHandler(param1.pkg);
         }
      }
      
      private function everyDayGiftRecordDataHandler(param1:PackageIn) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:Dictionary = new Dictionary();
         var _loc3_:int = param1.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = new ItemEveryDayRecordData();
            _loc4_.UserID = param1.readInt();
            _loc4_.TemplateID = param1.readInt();
            _loc4_.ItemID = param1.readInt();
            _loc4_.OpenTime = param1.readDate();
            _loc4_.OpenIndex = param1.readInt();
            _loc2_[_loc4_.TemplateID + "," + _loc4_.ItemID] = _loc4_;
            _loc5_++;
         }
         model.itemEveryDayRecord = _loc2_;
      }
      
      public function showFrame(param1:int, param2:Object = null) : void
      {
         var _loc7_:* = null;
         var _loc9_:* = null;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = null;
         frameType = param1;
         frameObj = param2;
         if(frameType == 1)
         {
            _loc7_ = frameObj as InventoryItemInfo;
            _loc9_ = ItemActivityGiftManager.instance.model.itemEveryDayRecord[_loc7_.TemplateID + "," + _loc7_.ItemID];
            _loc6_ = 0;
            if(_loc9_)
            {
               _loc6_ = _loc9_.OpenIndex;
            }
            else
            {
               _loc6_ = 0;
            }
            if(_loc6_ > 0)
            {
               _loc4_ = TimeManager.Instance.Now();
               if(_loc4_.getFullYear() == _loc9_.OpenTime.getFullYear() && _loc4_.getMonth() == _loc9_.OpenTime.getMonth() && _loc4_.getDay() == _loc9_.OpenTime.getDay())
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("itemActivityGift.frame.stepGiftLimit"));
                  return;
               }
            }
            _loc3_ = ServerConfigManager.instance.getEveryDayOpenPrice[_loc6_];
            _loc8_ = _loc3_.split(",");
            _loc5_ = "";
            if(_loc8_[0] == -300)
            {
               _loc5_ = _loc8_[1] + " " + LanguageMgr.GetTranslation("ddtMoney");
            }
            else if(_loc8_[0] == -200)
            {
               _loc5_ = _loc8_[1] + " " + LanguageMgr.GetTranslation("money");
            }
            tipsFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("itemActivityGift.frame.everyDayGiftRecordTxt",_loc6_ + 1,_loc5_),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
            tipsFrame.addEventListener("response",__onFrameResponse);
         }
      }
      
      private function __onFrameResponse(param1:FrameEvent) : void
      {
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = null;
         SoundManager.instance.play("008");
         tipsDispose();
         if(!(int(frameType) - 1))
         {
            if(param1.responseCode == 2 || param1.responseCode == 3)
            {
               _loc4_ = frameObj as InventoryItemInfo;
               _loc6_ = ItemActivityGiftManager.instance.model.itemEveryDayRecord[_loc4_.TemplateID + "," + _loc4_.ItemID];
               _loc3_ = 0;
               if(_loc6_)
               {
                  _loc3_ = _loc6_.OpenIndex;
               }
               else
               {
                  _loc3_ = 0;
               }
               _loc2_ = ServerConfigManager.instance.getEveryDayOpenPrice[_loc3_];
               _loc5_ = _loc2_.split(",");
               if(_loc5_[0] == -300 && PlayerManager.Instance.Self.BandMoney < _loc5_[1])
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               }
               else if(_loc5_[0] == -200 && PlayerManager.Instance.Self.Money < _loc5_[1])
               {
                  LeavePageManager.showFillFrame();
               }
               else
               {
                  SocketManager.Instance.out.sendUseEveryDayGiftRecord(_loc4_.TemplateID,_loc4_.ItemID,_loc3_ + 1);
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
