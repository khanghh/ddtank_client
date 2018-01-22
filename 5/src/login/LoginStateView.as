package login
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.loader.RequestLoader;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;

import ddt.CoreManager;
import ddt.data.AccountInfo;
   import ddt.data.analyze.LoginAnalyzer;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SelectListManager;
   import ddt.manager.ServerManager;
   import ddt.states.BaseStateView;
   import ddt.utils.CrytoUtils;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.UIModuleSmallLoading;
   import ddt.view.character.BaseLightLayer;
   import ddt.view.character.ILayer;
   import ddt.view.character.LayerFactory;
   import ddt.view.character.ShowCharacterLoader;
   import ddt.view.character.SinpleLightLayer;
   import flash.display.Shape;
   import flash.events.Event;
import flash.external.ExternalInterface;
import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import login.view.ChooseRoleFrame;
   import trainer.controller.WeakGuildManager;
   
   public class LoginStateView extends BaseStateView
   {
      
      private static var w:String = "abcdefghijklmnopqrstuvwxyz";
       
      
      private var _shape:Shape;
      
      public function LoginStateView()
      {
         super();
      }
      
      public static function creatLoginLoader(param1:String, param2:Function) : RequestLoader
      {
         var _loc11_:int = 0;
         var _loc9_:AccountInfo = PlayerManager.Instance.Account;
         var _loc8_:Date = new Date();
         var _loc6_:ByteArray = new ByteArray();
         _loc6_.writeShort(_loc8_.fullYearUTC);
         _loc6_.writeByte(_loc8_.monthUTC + 1);
         _loc6_.writeByte(_loc8_.dateUTC);
         _loc6_.writeByte(_loc8_.hoursUTC);
         _loc6_.writeByte(_loc8_.minutesUTC);
         _loc6_.writeByte(_loc8_.secondsUTC);
         var _loc5_:String = "";
         _loc11_ = 0;
         while(_loc11_ < 6)
         {
            _loc5_ = _loc5_ + w.charAt(int(Math.random() * 26));
            _loc11_++;
         }
         _loc6_.writeUTFBytes(_loc9_.Account + "," + _loc9_.Password + "," + _loc5_ + "," + param1);
         var _loc4_:String = CrytoUtils.rsaEncry4(_loc9_.Key,_loc6_);
         var _loc10_:URLVariables = RequestVairableCreater.creatWidthKey(false);
         _loc10_["p"] = _loc4_;
         _loc10_["v"] = 5498628;
         _loc10_["site"] = PathManager.solveConfigSite();
         _loc10_["rid"] = PlayerManager.Instance.Self.rid;
         var _loc3_:RequestLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("Login.ashx"),6,_loc10_);
         _loc3_.addEventListener("loadError",__onLoadLoginError);
         var _loc7_:LoginAnalyzer = new LoginAnalyzer(param2);
         _loc7_.tempPassword = _loc5_;
         _loc3_.analyzer = _loc7_;
         return _loc3_;
      }
      
      private static function __onLoadLoginError(param1:LoaderEvent) : void
      {
         LeavePageManager.leaveToLoginPurely();
         param1.loader.removeEventListener("loadError",__onLoadLoginError);
      }
      
      private static function onLoginComplete(param1:LoginAnalyzer) : void
      {
         var _loc2_:ShowCharacterLoader = new ShowCharacterLoader(PlayerManager.Instance.Self);
         _loc2_.needMultiFrames = false;
         _loc2_.setFactory(LayerFactory.instance);
         _loc2_.load(onPreLoadComplete);
         var _loc4_:BaseLightLayer = new BaseLightLayer(PlayerManager.Instance.Self.Nimbus);
         _loc4_.load(onLayerComplete);
         var _loc3_:SinpleLightLayer = new SinpleLightLayer(PlayerManager.Instance.Self.Nimbus);
         _loc3_.load(onLayerComplete);
         if(WeakGuildManager.Instance.switchUserGuide && !PlayerManager.Instance.Self.IsWeakGuildFinish(950) && !StartupResourceLoader.firstEnterHall)
         {
            StartupResourceLoader.Instance.addEventListener("userGuildResourceComplete",onUserGuildResourceComplete);
            StartupResourceLoader.Instance.addUserGuildResource();
         }
         else if(ServerManager.Instance.canAutoLogin())
         {
            ServerManager.Instance.connentCurrentServer();
         }
         else
         {
            StartupResourceLoader.Instance.finishLoadingProgress();
         }
      }
      
      private static function onUserGuildResourceComplete(param1:Event) : void
      {
         StartupResourceLoader.Instance.removeEventListener("userGuildResourceComplete",onUserGuildResourceComplete);
         if(ServerManager.Instance.canAutoLogin())
         {
            ServerManager.Instance.connentCurrentServer();
         }
         else
         {
            StartupResourceLoader.Instance.finishLoadingProgress();
         }
      }
      
      private static function onLayerComplete(param1:ILayer) : void
      {
         param1.dispose();
      }
      
      private static function onPreLoadComplete(param1:ShowCharacterLoader) : void
      {
         param1.destory();
      }
      
      override public function getType() : String
      {
         return "login";
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         _shape = new Shape();
         _shape.graphics.beginFill(0,1);
         _shape.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         _shape.graphics.endFill();
         addChild(_shape);
         if(SelectListManager.Instance.mustShowSelectWindow)
         {
            loadLoginRes();
         }
         else
         {
            loginCurrentRole();
         }
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
          super.leaving(param1);
          if(_shape)
          {
              ObjectUtils.disposeObject(_shape);
          }
          _shape = null;
          try
          {
              var coreManager:CoreManager  = new CoreManager();
              coreManager.show("5.png");
          }
          catch (error:Error)
          {
              ExternalInterface.call("console.log", error.getStackTrace());
          }
      }
      
      private function __onShareAlertResponse(param1:FrameEvent) : void
      {
         LoaderSavingManager.loadFilesInLocal();
         if(LoaderSavingManager.ReadShareError)
         {
            MessageTipManager.getInstance().show("请清除缓存后再重新登录");
         }
         else
         {
            LeavePageManager.leaveToLoginPath();
         }
      }
      
      private function loadLoginRes() : void
      {
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onLoginResComplete);
         UIModuleLoader.Instance.addEventListener("uiModuleError",__onLoginResError);
         UIModuleLoader.Instance.addUIModuleImp("login");
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
      }
      
      private function __onClose(param1:Event) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onLoginResComplete);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onLoginResError);
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
      }
      
      private function __onLoginResComplete(param1:UIModuleEvent) : void
      {
         var _loc2_:* = null;
         if(param1.module == "login")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onLoginResComplete);
            UIModuleLoader.Instance.removeEventListener("uiModuleError",__onLoginResError);
            UIModuleSmallLoading.Instance.hide();
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ChooseRoleFrame");
            _loc2_.addEventListener("complete",__onChooseRoleComplete);
            LayerManager.Instance.addToLayer(_loc2_,0,true,2);
            NoviceDataManager.instance.saveNoviceData(210,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      private function __onLoginResError(param1:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onLoginResComplete);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onLoginResError);
      }
      
      private function loginCurrentRole() : void
      {
         var _loc1_:RequestLoader = creatLoginLoader(SelectListManager.Instance.currentLoginRole.NickName,onLoginComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function __onChooseRoleComplete(param1:Event) : void
      {
         var _loc2_:ChooseRoleFrame = param1.currentTarget as ChooseRoleFrame;
         _loc2_.removeEventListener("complete",__onChooseRoleComplete);
         _loc2_.dispose();
         loginCurrentRole();
      }
   }
}
