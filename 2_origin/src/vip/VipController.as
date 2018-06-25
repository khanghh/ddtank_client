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
            var selfInfo:* = null;
            var rechargeAlertTxt:* = null;
            if(_rechargeAlertFrame == null)
            {
               _rechargeAlertFrame = ComponentFactory.Instance.creatComponentByStylename("vip.vipRechargeAlertFrame");
               selfInfo = PlayerManager.Instance.Self;
               rechargeAlertTxt = new RechargeAlertTxt();
               rechargeAlertTxt.AlertContent = selfInfo.VIPLevel;
               _rechargeAlertFrame.content = rechargeAlertTxt;
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
      
      protected function __responseHandler(event:FrameEvent) : void
      {
         _helpframe.removeEventListener("response",__responseHandler);
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               _helpframe.dispose();
         }
      }
      
      protected function __responseRechargeAlertHandler(event:FrameEvent) : void
      {
         _rechargeAlertFrame.removeEventListener("response",__responseRechargeAlertHandler);
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
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
      
      public function sendOpenVip(name:String, days:int, bool:Boolean = true) : void
      {
         SocketManager.Instance.out.sendOpenVip(name,days,bool);
      }
      
      public function hide() : void
      {
         if(_vipFrame != null)
         {
            _vipFrame.dispose();
         }
         _vipFrame = null;
      }
      
      public function getVipNameTxt($width:int = -1, typeVIP:int = 1) : GradientText
      {
         var text:* = null;
         switch(int(typeVIP))
         {
            case 0:
               throw new Error("会员类型错误,不能为非会员玩家创建会员字体.");
            case 1:
               text = ComponentFactory.Instance.creatComponentByStylename("vipName");
            case 2:
               text = ComponentFactory.Instance.creatComponentByStylename("vipName");
         }
      }
      
      public function getVIPStrengthenEx(level:int) : Number
      {
         if(level - 1 < 0)
         {
            return 0;
         }
         var arr:Array = ServerConfigManager.instance.VIPStrengthenEx;
         if(arr)
         {
            return arr[level - 1];
         }
         return 0;
      }
   }
}
