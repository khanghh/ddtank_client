package login{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.LoaderSavingManager;   import com.pickgliss.loader.RequestLoader;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.manager.NoviceDataManager;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.AccountInfo;   import ddt.data.analyze.LoginAnalyzer;   import ddt.loader.StartupResourceLoader;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SelectListManager;   import ddt.manager.ServerManager;   import ddt.states.BaseStateView;   import ddt.utils.CrytoUtils;   import ddt.utils.RequestVairableCreater;   import ddt.view.UIModuleSmallLoading;   import ddt.view.character.BaseLightLayer;   import ddt.view.character.ILayer;   import ddt.view.character.LayerFactory;   import ddt.view.character.ShowCharacterLoader;   import ddt.view.character.SinpleLightLayer;   import flash.display.Shape;   import flash.events.Event;   import flash.net.URLVariables;   import flash.utils.ByteArray;   import login.view.ChooseRoleFrame;   import trainer.controller.WeakGuildManager;      public class LoginStateView extends BaseStateView   {            private static var w:String = "abcdefghijklmnopqrstuvwxyz";                   private var _shape:Shape;            public function LoginStateView() { super(); }
            public static function creatLoginLoader(nickname:String, callBack:Function) : RequestLoader { return null; }
            private static function __onLoadLoginError(event:LoaderEvent) : void { }
            private static function onLoginComplete(analyzer:LoginAnalyzer) : void { }
            private static function onUserGuildResourceComplete(evt:Event) : void { }
            private static function onLayerComplete(layer:ILayer) : void { }
            private static function onPreLoadComplete(loader:ShowCharacterLoader) : void { }
            override public function getType() : String { return null; }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            override public function leaving(next:BaseStateView) : void { }
            private function __onShareAlertResponse(event:FrameEvent) : void { }
            private function loadLoginRes() : void { }
            private function __onClose(event:Event) : void { }
            private function __onLoginResComplete(evt:UIModuleEvent) : void { }
            private function __onLoginResError(evt:UIModuleEvent) : void { }
            private function loginCurrentRole() : void { }
            private function __onChooseRoleComplete(event:Event) : void { }
   }}