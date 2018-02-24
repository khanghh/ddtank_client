package vip
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.GradientText;
   import ddt.data.player.SelfInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.EventDispatcher;
   import vip.data.VipModelInfo;
   import vip.view.RechargeAlertTxt;
   import vip.view.VIPHelpFrame;
   import vip.view.VIPRechargeAlertFrame;
   import vip.view.VipFrame;
   import vip.view.VipViewFrame;
   
   public class VipController extends EventDispatcher
   {
      
      private static var _instance:VipController;
       
      
      public var info:VipModelInfo;
      
      public var isRechargePoped:Boolean;
      
      private var _vipFrame:VipFrame;
      
      private var _vipViewFrame:VipViewFrame;
      
      private var _isShow:Boolean;
      
      private var _helpframe:VIPHelpFrame;
      
      private var _rechargeAlertFrame:VIPRechargeAlertFrame;
      
      private var _rechargeAlertLoad:Boolean = false;
      
      public function VipController(){super();}
      
      public static function get instance() : VipController{return null;}
      
      public function show() : void{}
      
      private function showVipFrame() : void{}
      
      public function showRechargeAlert() : void{}
      
      public function helpframeNull() : void{}
      
      protected function __responseHandler(param1:FrameEvent) : void{}
      
      protected function __responseRechargeAlertHandler(param1:FrameEvent) : void{}
      
      public function sendOpenVip(param1:String, param2:int, param3:Boolean = true) : void{}
      
      public function hide() : void{}
      
      public function getVipNameTxt(param1:int = -1, param2:int = 1) : GradientText{return null;}
      
      public function getVIPStrengthenEx(param1:int) : Number{return 0;}
   }
}
