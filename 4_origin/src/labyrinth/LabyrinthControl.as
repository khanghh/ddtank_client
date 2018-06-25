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
      
      public function LabyrinthControl(target:IEventDispatcher = null)
      {
         super(target);
         CleanOutConfirmView;
         CleanOutContentItem;
         LabyrinthBoxIconTips;
         RankingListItem;
         _manager = LabyrinthManager.Instance;
      }
      
      public static function get Instance() : LabyrinthControl
      {
         if(_instance == null)
         {
            _instance = new LabyrinthControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         RoomManager.Instance.addEventListener("startLabyrinth",__sendStart);
         SocketManager.Instance.addEventListener(PkgEvent.format(131,9),__onTryAgain);
         LabyrinthManager.Instance.addEventListener("LabyrinthOpenView",__onOpenView);
      }
      
      protected function __onTryAgain(event:PkgEvent) : void
      {
         var missionAgain:MissionAgainInfo = new MissionAgainInfo();
         againSelectType = event.pkg.readInt();
         missionAgain.value = event.pkg.readInt();
         missionAgain.host = PlayerManager.Instance.Self.NickName;
         tryagain = new LabyrinthTryAgain(missionAgain,false);
         PositionUtils.setPos(tryagain,"dt.labyrinth.LabyrinthFrame.TryAgainPos");
         tryagain.addEventListener("tryagain",__tryAgain);
         tryagain.addEventListener("giveup",__giveup);
         LayerManager.Instance.addToLayer(tryagain,3,false,2);
         hideLabyrinthFrame();
      }
      
      protected function __giveup(event:GameEvent) : void
      {
         SocketManager.Instance.out.labyrinthTryAgain(againSelectType,false,event.data);
         disposeTryAgain();
         _manager.model.tryAgainComplete = false;
      }
      
      protected function __tryAgain(event:GameEvent) : void
      {
         SocketManager.Instance.out.labyrinthTryAgain(againSelectType,true,event.data);
         disposeTryAgain();
         _manager.model.tryAgainComplete = true;
      }
      
      private function disposeTryAgain() : void
      {
         if(tryagain)
         {
            tryagain.removeEventListener("tryagain",__tryAgain);
            tryagain.removeEventListener("giveup",__giveup);
            ObjectUtils.disposeObject(tryagain);
            tryagain = null;
         }
      }
      
      protected function __sendStart(event:Event) : void
      {
         GameInSocketOut.sendGameStart();
      }
      
      protected function __startLoading(e:Event) : void
      {
         if(RoomManager.Instance.current && (RoomManager.Instance.current.type == 15 || RoomManager.Instance.current.type == 70))
         {
            StateManager.getInGame_Step_6 = true;
            if(GameControl.Instance.Current == null)
            {
               return;
            }
            LayerManager.Instance.clearnGameDynamic();
            StateManager.setState("roomLoading",GameControl.Instance.Current);
            StateManager.getInGame_Step_7 = true;
         }
      }
      
      protected function __onOpenView(event:Event) : void
      {
         show();
      }
      
      public function show() : void
      {
         _callback = show;
         if(_UILoadComplete)
         {
            labyrinthFrame = ComponentFactory.Instance.creatCustomObject("labyrinth.labyrinthFrame");
            labyrinthFrame.show();
            labyrinthFrame.addEventListener("response",__labyrinthFrameEvent);
         }
         else
         {
            loadUIModule();
         }
      }
      
      protected function __labyrinthFrameEvent(event:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(event.responseCode == 1 || event.responseCode == 0 || event.responseCode == 4)
         {
            hideLabyrinthFrame();
         }
      }
      
      private function hideLabyrinthFrame() : void
      {
         if(labyrinthFrame)
         {
            labyrinthFrame.removeEventListener("response",__labyrinthFrameEvent);
            labyrinthFrame.dispose();
            labyrinthFrame = null;
         }
      }
      
      public function loadRankingList(selectType:int = 0) : void
      {
         var args:URLVariables = new URLVariables();
         args["id"] = PlayerManager.Instance.Self.ID;
         args["rnd"] = Math.random();
         var requestName:String = "WarriorFamRankList.xml";
         if(selectType == 1)
         {
            requestName = "WarriorHighFamRankList.xml";
         }
         var loader:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath(requestName),2,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingWarriorFamRankListFailure");
         loader.analyzer = new RankingAnalyzer(openRankingFrame);
      }
      
      private function openRankingFrame(action:RankingAnalyzer) : void
      {
         _manager.model.rankingList = action.list;
         dispatchEvent(new Event("rankingLoadComplete"));
      }
      
      public function loadUIModule() : void
      {
         if(!_UILoadComplete)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onProgress);
            UIModuleLoader.Instance.addUIModuleImp("labyrinth");
            UIModuleLoader.Instance.addUIModuleImp("ddtshop");
         }
      }
      
      protected function __onProgress(event:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
      }
      
      protected function __onUIModuleComplete(event:UIModuleEvent) : void
      {
         if(event.module == "labyrinth" || event.module == "ddtshop")
         {
            _loadProgress = Number(_loadProgress) + 1;
            if(_loadProgress >= 2)
            {
               _UILoadComplete = true;
            }
         }
         if(_UILoadComplete)
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleSmallLoading.Instance.hide();
            if(_callback != null)
            {
               _callback();
            }
            BuriedControl.Instance.dispatchEvent(new BuriedEvent("labyrith_over"));
         }
      }
      
      public function get UILoadComplete() : Boolean
      {
         return _UILoadComplete;
      }
      
      protected function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
      }
   }
}
