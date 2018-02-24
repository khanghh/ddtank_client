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
      
      public function ItemActivityGiftManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : ItemActivityGiftManager{return null;}
      
      public function get model() : ItemActivityGiftModel{return null;}
      
      public function setup() : void{}
      
      private function __itemActivityGiftDataHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function everyDayGiftRecordDataHandler(param1:PackageIn) : void{}
      
      public function showFrame(param1:int, param2:Object = null) : void{}
      
      private function __onFrameResponse(param1:FrameEvent) : void{}
      
      private function tipsDispose() : void{}
   }
}
