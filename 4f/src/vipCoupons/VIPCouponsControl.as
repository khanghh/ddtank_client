package vipCoupons
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.FilterWordManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import road7th.comm.PackageIn;
   import road7th.utils.StringHelper;
   import vip.VipController;
   import vipCoupons.view.VIPCouponsFrame;
   
   public class VIPCouponsControl extends EventDispatcher
   {
      
      private static var _instance:VIPCouponsControl;
       
      
      private var _frame:VIPCouponsFrame;
      
      private var _baseAlerFrame:BaseAlerFrame;
      
      private var _bagType:int;
      
      private var _place:int;
      
      public function VIPCouponsControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : VIPCouponsControl{return null;}
      
      public function setup() : void{}
      
      private function __openViewHandler(param1:CEvent) : void{}
      
      private function openFrame() : void{}
      
      protected function _responseHandle(param1:FrameEvent) : void{}
      
      protected function __sendHandler(param1:MouseEvent) : void{}
      
      private function getItemCount(param1:int) : int{return 0;}
      
      private function __useVipCouponsHandler(param1:CEvent) : void{}
      
      private function __frameEvent(param1:FrameEvent) : void{}
      
      private function __tasteVipCouponsHandler(param1:PkgEvent) : void{}
      
      private function __tasteVipHandler(param1:FrameEvent) : void{}
      
      public function dispose() : void{}
   }
}
