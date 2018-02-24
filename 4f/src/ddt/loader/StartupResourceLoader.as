package ddt.loader
{
   import GodSyah.SyahManager;
   import SendRecord.SendRecordManager;
   import bones.BoneMovieFactory;
   import bones.loader.BonesLoaderEvent;
   import bones.loader.BonesLoaderManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.LoaderManager;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.events.PkgEvent;
   import ddt.events.StartupEvent;
   import ddt.manager.DesktopManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import deng.fzip.FZip;
   import deng.fzip.FZipFile;
   import email.MailManager;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.utils.ByteArray;
   import road7th.StarlingPre;
   import road7th.comm.PackageIn;
   import starling.loader.StarlingQueueLoader;
   
   public class StartupResourceLoader extends EventDispatcher
   {
      
      public static const NEWBIE:int = 1;
      
      public static const NORMAL:int = 2;
      
      public static const USER_GUILD_RESOURCE_COMPLETE:String = "userGuildResourceComplete";
      
      private static var _instance:StartupResourceLoader;
      
      public static var firstEnterHall:Boolean = false;
       
      
      private var _currentMode:int = 0;
      
      private var starlingPre:StarlingPre;
      
      private var _languageLoader:BaseLoader;
      
      private var _languagePath:String;
      
      private var _isSecondLoad:Boolean = false;
      
      private var _starlingQueueLoader:StarlingQueueLoader;
      
      private var _uimoduleProgress:Number;
      
      private var _progressArr:Array;
      
      private var _trainerComplete:Boolean;
      
      private var _trainerUIComplete:Boolean;
      
      private var _trainerFristComplete:Boolean;
      
      public var _queueIsComplete:Boolean;
      
      private var _loaderQueue:QueueLoader;
      
      private var _requestCompleted:int;
      
      public function StartupResourceLoader(){super();}
      
      public static function get Instance() : StartupResourceLoader{return null;}
      
      private function __reloadXML(param1:PkgEvent) : void{}
      
      private function __onUIModuleLoadError(param1:UIModuleEvent) : void{}
      
      private function __onAlertResponse(param1:FrameEvent) : void{}
      
      public function get progress() : int{return 0;}
      
      public function start(param1:int) : void{}
      
      private function loadLanguage() : void{}
      
      private function __onLoadLanZipComplete(param1:LoaderEvent) : void{}
      
      private function zipLoad(param1:ByteArray) : void{}
      
      private function analyMd5(param1:ByteArray) : void{}
      
      private function hasHead(param1:ByteArray) : Boolean{return false;}
      
      private function compareMD5(param1:ByteArray) : Boolean{return false;}
      
      private function __onZipParaComplete(param1:Event) : void{}
      
      private function __onLoaderBonesComplete(param1:BonesLoaderEvent) : void{}
      
      private function __onLoadLanguageComplete(param1:Event) : void{}
      
      private function onStarlingQueueComplete() : void{}
      
      private function __onUIModuleProgress(param1:UIModuleEvent) : void{}
      
      private function setLoaderProgressArr(param1:String, param2:Number = 0) : void{}
      
      public function addUserGuildResource() : void{}
      
      public function finishLoadingProgress() : void{}
      
      public function startLoadRelatedInfo() : void{}
      
      private function __onSetupSourceLoadComplete(param1:Event) : void{}
      
      private function __onUIMoudleComplete(param1:UIModuleEvent) : void{}
      
      private function newBieXML() : void{}
      
      private function addLoader(param1:BaseLoader) : void{}
      
      private function __onSetupSourceLoadChange(param1:Event) : void{}
      
      public function addRegisterUIModule() : void{}
      
      public function addThirdGameUI() : void{}
      
      private function loadUIModule() : void{}
      
      public function addFirstGameNotStartupNeededResource() : void{}
      
      public function addNotStartupNeededResource() : void{}
      
      private function addUIModlue(param1:String) : void{}
      
      private function _setStageRightMouse() : void{}
      
      private function creatRightMenu() : ContextMenu{return null;}
      
      private function onQQMSNClick(param1:ContextMenuEvent) : void{}
      
      public function receivedFromJavaScript(param1:String) : void{}
      
      private function _receivedFromJavaScriptII(param1:String) : void{}
      
      private function SendVersion() : void{}
      
      private function sendRecordUserVersion() : void{}
      
      private function sendUserVersion() : void{}
      
      private function addFavClick(param1:ContextMenuEvent) : void{}
      
      private function goPayClick(param1:ContextMenuEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      public function reloadGodSyah(param1:PackageIn) : void{}
   }
}
