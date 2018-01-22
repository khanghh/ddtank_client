package labyrinth
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.GameEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.UIModuleSmallLoading;
   import ddtBuried.BuriedControl;
   import ddtBuried.event.BuriedEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.net.URLVariables;
   import gameCommon.GameControl;
   import gameCommon.model.MissionAgainInfo;
   import labyrinth.data.RankingAnalyzer;
   import labyrinth.view.CleanOutConfirmView;
   import labyrinth.view.CleanOutContentItem;
   import labyrinth.view.LabyrinthBoxIconTips;
   import labyrinth.view.LabyrinthFrame;
   import labyrinth.view.LabyrinthTryAgain;
   import labyrinth.view.RankingListItem;
   import room.RoomManager;
   
   public class LabyrinthControl extends EventDispatcher
   {
      
      public static const RANKING_LOAD_COMPLETE:String = "rankingLoadComplete";
      
      private static var _instance:LabyrinthControl;
       
      
      public var buyFrameEnable:Boolean = true;
      
      private var _UILoadComplete:Boolean = false;
      
      private var _loadProgress:int = 0;
      
      private var labyrinthFrame:LabyrinthFrame;
      
      private var _manager:LabyrinthManager;
      
      private var tryagain:LabyrinthTryAgain;
      
      private var againSelectType:int;
      
      private var _callback:Function;
      
      public function LabyrinthControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : LabyrinthControl{return null;}
      
      public function setup() : void{}
      
      protected function __onTryAgain(param1:PkgEvent) : void{}
      
      protected function __giveup(param1:GameEvent) : void{}
      
      protected function __tryAgain(param1:GameEvent) : void{}
      
      private function disposeTryAgain() : void{}
      
      protected function __sendStart(param1:Event) : void{}
      
      protected function __startLoading(param1:Event) : void{}
      
      protected function __onOpenView(param1:Event) : void{}
      
      public function show() : void{}
      
      protected function __labyrinthFrameEvent(param1:FrameEvent) : void{}
      
      private function hideLabyrinthFrame() : void{}
      
      public function loadRankingList(param1:int = 0) : void{}
      
      private function openRankingFrame(param1:RankingAnalyzer) : void{}
      
      public function loadUIModule() : void{}
      
      protected function __onProgress(param1:UIModuleEvent) : void{}
      
      protected function __onUIModuleComplete(param1:UIModuleEvent) : void{}
      
      public function get UILoadComplete() : Boolean{return false;}
      
      protected function __onClose(param1:Event) : void{}
   }
}
