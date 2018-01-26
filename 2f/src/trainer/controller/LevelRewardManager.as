package trainer.controller
{
   import com.pickgliss.action.AlertAction;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.analyze.LevelRewardAnalyzer;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.utils.Dictionary;
   import trainer.data.LevelRewardInfo;
   import trainer.view.LevelRewardFrame;
   import trainer.view.SecondOnlineView;
   
   public class LevelRewardManager
   {
      
      private static var _instance:LevelRewardManager;
       
      
      public var _isShow:Boolean;
      
      private var _reward:Dictionary;
      
      private var _fr:LevelRewardFrame;
      
      public function LevelRewardManager(){super();}
      
      public static function get Instance() : LevelRewardManager{return null;}
      
      public function get isShow() : Boolean{return false;}
      
      public function set isShow(param1:Boolean) : void{}
      
      public function setup() : void{}
      
      private function onDataComplete(param1:LevelRewardAnalyzer) : void{}
      
      private function __onChange(param1:PlayerPropertyEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      public function getRewardInfo(param1:int, param2:int) : LevelRewardInfo{return null;}
      
      public function showSecFrame() : void{}
      
      public function showFrame(param1:int) : void{}
      
      public function hide() : void{}
   }
}
