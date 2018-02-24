package trainer.controller
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PreviewFrameManager;
   import ddt.manager.SocketManager;
   import ddt.view.MainToolBar;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import road7th.utils.MovieClipWrapper;
   
   public class WeakGuildManager
   {
      
      private static var _instance:WeakGuildManager;
       
      
      private const LV:int = 15;
      
      private var _type:String;
      
      private var _title:String;
      
      private var _newTask:Boolean;
      
      private var _bmpLoader:BitmapLoader;
      
      public function WeakGuildManager(){super();}
      
      public static function get Instance() : WeakGuildManager{return null;}
      
      public function get switchUserGuide() : Boolean{return false;}
      
      public function get newTask() : Boolean{return false;}
      
      public function set newTask(param1:Boolean) : void{}
      
      public function setup() : void{}
      
      private function __onChange(param1:PlayerPropertyEvent) : void{}
      
      public function timeStatistics(param1:int, param2:Number) : void{}
      
      public function statistics(param1:int, param2:Number) : void{}
      
      public function setStepFinish(param1:int) : void{}
      
      public function showMainToolBarBtnOpen(param1:int, param2:String) : void{}
      
      public function checkFunction() : void{}
      
      public function checkOpen(param1:int, param2:int) : Boolean{return false;}
      
      public function openBuildTip(param1:String) : void{}
      
      public function showBuildPreview(param1:String, param2:String) : void{}
      
      private function __loadProgress(param1:LoaderEvent) : void{}
      
      private function __loadComplete(param1:LoaderEvent) : void{}
      
      private function __onClose(param1:Event) : void{}
      
      private function disposeBmpLoader() : void{}
      
      private function checkLevelFunction() : void{}
      
      private function openFunction(param1:int) : void{}
   }
}
