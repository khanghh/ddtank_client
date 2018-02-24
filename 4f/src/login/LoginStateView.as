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
      
      public function LoginStateView(){super();}
      
      public static function creatLoginLoader(param1:String, param2:Function) : RequestLoader{return null;}
      
      private static function __onLoadLoginError(param1:LoaderEvent) : void{}
      
      private static function onLoginComplete(param1:LoginAnalyzer) : void{}
      
      private static function onUserGuildResourceComplete(param1:Event) : void{}
      
      private static function onLayerComplete(param1:ILayer) : void{}
      
      private static function onPreLoadComplete(param1:ShowCharacterLoader) : void{}
      
      override public function getType() : String{return null;}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      private function __onShareAlertResponse(param1:FrameEvent) : void{}
      
      private function loadLoginRes() : void{}
      
      private function __onClose(param1:Event) : void{}
      
      private function __onLoginResComplete(param1:UIModuleEvent) : void{}
      
      private function __onLoginResError(param1:UIModuleEvent) : void{}
      
      private function loginCurrentRole() : void{}
      
      private function __onChooseRoleComplete(param1:Event) : void{}
   }
}
