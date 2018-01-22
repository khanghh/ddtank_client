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
      
      public function VipController()
      {
         super();
      }
      
      public static function get instance() : VipController
      {
         if(!_instance)
         {
            _instance = new VipController();
         }
         return _instance;
      }
      
      public function show() : void
      {
         AssetModuleLoader.addModelLoader("ddtvipview",6);
         AssetModuleLoader.startCodeLoader(showVipFrame);
      }
      
      private function showVipFrame() : void
      {
         _vipFrame = ComponentFactory.Instance.creatComponentByStylename("vip.VipFrame");
         _vipFrame.show();
      }
      
      public function showRechargeAlert() : void
      {
         AssetModuleLoader.addModelLoader("ddtvipview",6);
         AssetModuleLoader.startCodeLoader(function():void
         {
            var _loc1_:* = null;
            var _loc2_:* = null;
            if(_rechargeAlertFrame == null)
            {
               _rechargeAlertFrame = ComponentFactory.Instance.creatComponentByStylename("vip.vipRechargeAlertFrame");
               _loc1_ = PlayerManager.Instance.Self;
               _loc2_ = new RechargeAlertTxt();
               _loc2_.AlertContent = _loc1_.VIPLevel;
               _rechargeAlertFrame.content = _loc2_;
               _rechargeAlertFrame.show();
               _rechargeAlertFrame.addEventListener("response",__responseRechargeAlertHandler);
            }
         });
      }
      
      public function helpframeNull() : void
      {
         if(_helpframe)
         {
            _helpframe = null;
         }
      }
      
      protected function __responseHandler(param1:FrameEvent) : void
      {
         _helpframe.removeEventListener("response",__responseHandler);
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _helpframe.dispose();
         }
      }
      
      protected function __responseRechargeAlertHandler(param1:FrameEvent) : void
      {
         _rechargeAlertFrame.removeEventListener("response",__responseRechargeAlertHandler);
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _rechargeAlertFrame.dispose();
         }
         if(_rechargeAlertFrame)
         {
            _rechargeAlertFrame = null;
         }
      }
      
      public function sendOpenVip(param1:String, param2:int, param3:Boolean = true) : void
      {
         SocketManager.Instance.out.sendOpenVip(param1,param2,param3);
      }
      
      public function hide() : void
      {
         if(_vipFrame != null)
         {
            _vipFrame.dispose();
         }
         _vipFrame = null;
      }
      
      public function getVipNameTxt(param1:int = -1, param2:int = 1) : GradientText
      {
         var _loc3_:* = null;
         switch(int(param2))
         {
            case 0:
               throw new Error("会员类型错误,不能为非会员玩家创建会员字体.");
            case 1:
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("vipName");
            case 2:
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("vipName");
         }
      }
      
      public function getVIPStrengthenEx(param1:int) : Number
      {
         if(param1 - 1 < 0)
         {
            return 0;
         }
         var _loc2_:Array = ServerConfigManager.instance.VIPStrengthenEx;
         if(_loc2_)
         {
            return _loc2_[param1 - 1];
         }
         return 0;
      }
   }
}
