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
      
      public static function creatLoginLoader(nickname:String, callBack:Function) : RequestLoader
      {
         var i:int = 0;
         var acc:AccountInfo = PlayerManager.Instance.Account;
         var date:Date = new Date();
         var temp:ByteArray = new ByteArray();
         temp.writeShort(date.fullYearUTC);
         temp.writeByte(date.monthUTC + 1);
         temp.writeByte(date.dateUTC);
         temp.writeByte(date.hoursUTC);
         temp.writeByte(date.minutesUTC);
         temp.writeByte(date.secondsUTC);
         var tempPassword:String = "";
         for(i = 0; i < 6; )
         {
            tempPassword = tempPassword + w.charAt(int(Math.random() * 26));
            i++;
         }
         temp.writeUTFBytes(acc.Account + "," + acc.Password + "," + tempPassword + "," + nickname);
         var p:String = CrytoUtils.rsaEncry4(acc.Key,temp);
         var variables:URLVariables = RequestVairableCreater.creatWidthKey(false);
         variables["p"] = p;
         variables["v"] = 5498628;
         variables["site"] = PathManager.solveConfigSite();
         variables["rid"] = PlayerManager.Instance.Self.rid;
         var loader:RequestLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("Login.ashx"),6,variables);
         loader.addEventListener("loadError",__onLoadLoginError);
         var analyzer:LoginAnalyzer = new LoginAnalyzer(callBack);
         analyzer.tempPassword = tempPassword;
         loader.analyzer = analyzer;
         return loader;
      }
      
      private static function __onLoadLoginError(event:LoaderEvent) : void
      {
         LeavePageManager.leaveToLoginPurely();
         event.loader.removeEventListener("loadError",__onLoadLoginError);
      }
      
      private static function onLoginComplete(analyzer:LoginAnalyzer) : void
      {
         var perloader:ShowCharacterLoader = new ShowCharacterLoader(PlayerManager.Instance.Self);
         perloader.needMultiFrames = false;
         perloader.setFactory(LayerFactory.instance);
         perloader.load(onPreLoadComplete);
         var light:BaseLightLayer = new BaseLightLayer(PlayerManager.Instance.Self.Nimbus);
         light.load(onLayerComplete);
         var sinple:SinpleLightLayer = new SinpleLightLayer(PlayerManager.Instance.Self.Nimbus);
         sinple.load(onLayerComplete);
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
      
      private static function onUserGuildResourceComplete(evt:Event) : void
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
      
      private static function onLayerComplete(layer:ILayer) : void
      {
         layer.dispose();
      }
      
      private static function onPreLoadComplete(loader:ShowCharacterLoader) : void
      {
         loader.destory();
      }
      
      override public function getType() : String
      {
         return "login";
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
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
      
      override public function leaving(next:BaseStateView) : void
      {
         super.leaving(next);
         if(_shape)
         {
            ObjectUtils.disposeObject(_shape);
         }
         _shape = null;
      }
      
      private function __onShareAlertResponse(event:FrameEvent) : void
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
      
      private function __onClose(event:Event) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onLoginResComplete);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onLoginResError);
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
      }
      
      private function __onLoginResComplete(evt:UIModuleEvent) : void
      {
         var chooseRoleFrame:* = null;
         if(evt.module == "login")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onLoginResComplete);
            UIModuleLoader.Instance.removeEventListener("uiModuleError",__onLoginResError);
            UIModuleSmallLoading.Instance.hide();
            chooseRoleFrame = ComponentFactory.Instance.creatComponentByStylename("ChooseRoleFrame");
            chooseRoleFrame.addEventListener("complete",__onChooseRoleComplete);
            LayerManager.Instance.addToLayer(chooseRoleFrame,0,true,2);
            NoviceDataManager.instance.saveNoviceData(210,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      private function __onLoginResError(evt:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onLoginResComplete);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onLoginResError);
      }
      
      private function loginCurrentRole() : void
      {
         var loader:RequestLoader = creatLoginLoader(SelectListManager.Instance.currentLoginRole.NickName,onLoginComplete);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function __onChooseRoleComplete(event:Event) : void
      {
         var chooseRoleFrame:ChooseRoleFrame = event.currentTarget as ChooseRoleFrame;
         chooseRoleFrame.removeEventListener("complete",__onChooseRoleComplete);
         chooseRoleFrame.dispose();
         loginCurrentRole();
      }
   }
}
