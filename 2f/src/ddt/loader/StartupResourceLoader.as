package ddt.loader{   import GodSyah.SyahManager;   import SendRecord.SendRecordManager;   import bones.BoneMovieFactory;   import bones.loader.BonesLoaderEvent;   import bones.loader.BonesLoaderManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.LoaderManager;   import com.pickgliss.loader.LoaderSavingManager;   import com.pickgliss.loader.QueueLoader;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentSetting;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.events.PkgEvent;   import ddt.events.StartupEvent;   import ddt.manager.DesktopManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import deng.fzip.FZip;   import deng.fzip.FZipFile;   import email.MailManager;   import flash.events.ContextMenuEvent;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.external.ExternalInterface;   import flash.net.URLLoader;   import flash.net.URLRequest;   import flash.net.URLVariables;   import flash.system.Capabilities;   import flash.system.System;   import flash.ui.ContextMenu;   import flash.ui.ContextMenuItem;   import flash.utils.ByteArray;   import road7th.StarlingPre;   import road7th.comm.PackageIn;   import starling.loader.StarlingQueueLoader;      public class StartupResourceLoader extends EventDispatcher   {            public static const NEWBIE:int = 1;            public static const NORMAL:int = 2;            public static const USER_GUILD_RESOURCE_COMPLETE:String = "userGuildResourceComplete";            private static var _instance:StartupResourceLoader;            public static var firstEnterHall:Boolean = false;                   private var _currentMode:int = 0;            private var starlingPre:StarlingPre;            private var _languageLoader:BaseLoader;            private var _languagePath:String;            private var _isSecondLoad:Boolean = false;            private var _starlingQueueLoader:StarlingQueueLoader;            private var _uimoduleProgress:Number;            private var _progressArr:Array;            private var _trainerComplete:Boolean;            private var _trainerUIComplete:Boolean;            private var _trainerFristComplete:Boolean;            public var _queueIsComplete:Boolean;            private var _loaderQueue:QueueLoader;            private var _requestCompleted:int;            public function StartupResourceLoader() { super(); }
            public static function get Instance() : StartupResourceLoader { return null; }
            private function __reloadXML(event:PkgEvent) : void { }
            private function __onUIModuleLoadError(event:UIModuleEvent) : void { }
            private function __onAlertResponse(event:FrameEvent) : void { }
            public function get progress() : int { return 0; }
            public function start(mode:int) : void { }
            private function loadLanguage() : void { }
            private function __onLoadLanZipComplete(event:LoaderEvent) : void { }
            private function zipLoad(content:ByteArray) : void { }
            private function analyMd5(content:ByteArray) : void { }
            private function hasHead(temp:ByteArray) : Boolean { return false; }
            private function compareMD5(temp:ByteArray) : Boolean { return false; }
            private function __onZipParaComplete(event:Event) : void { }
            private function __onLoaderBonesComplete(e:BonesLoaderEvent) : void { }
            private function __onLoadLanguageComplete(event:Event) : void { }
            private function onStarlingQueueComplete() : void { }
            private function __onUIModuleProgress(event:UIModuleEvent) : void { }
            private function setLoaderProgressArr($name:String, num:Number = 0) : void { }
            public function addUserGuildResource() : void { }
            public function finishLoadingProgress() : void { }
            public function startLoadRelatedInfo() : void { }
            private function __onSetupSourceLoadComplete(event:Event) : void { }
            private function __onUIMoudleComplete(event:UIModuleEvent) : void { }
            private function newBieXML() : void { }
            private function addLoader(loader:BaseLoader) : void { }
            private function __onSetupSourceLoadChange(event:Event) : void { }
            public function addRegisterUIModule() : void { }
            public function addThirdGameUI() : void { }
            private function loadUIModule() : void { }
            public function addFirstGameNotStartupNeededResource() : void { }
            public function addNotStartupNeededResource() : void { }
            private function addUIModlue(ui:String) : void { }
            private function _setStageRightMouse() : void { }
            private function creatRightMenu() : ContextMenu { return null; }
            private function onQQMSNClick(e:ContextMenuEvent) : void { }
            public function receivedFromJavaScript(str:String) : void { }
            private function _receivedFromJavaScriptII(str:String) : void { }
            private function SendVersion() : void { }
            private function sendRecordUserVersion() : void { }
            private function sendUserVersion() : void { }
            private function addFavClick(e:ContextMenuEvent) : void { }
            private function goPayClick(e:ContextMenuEvent) : void { }
            private function _response(evt:FrameEvent) : void { }
            public function reloadGodSyah(pkg:PackageIn) : void { }
   }}