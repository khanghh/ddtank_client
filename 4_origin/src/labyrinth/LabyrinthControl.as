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
      
      public function LabyrinthControl(param1:IEventDispatcher = null)
      {
         super(param1);
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
      
      protected function __onTryAgain(param1:PkgEvent) : void
      {
         var _loc2_:MissionAgainInfo = new MissionAgainInfo();
         againSelectType = param1.pkg.readInt();
         _loc2_.value = param1.pkg.readInt();
         _loc2_.host = PlayerManager.Instance.Self.NickName;
         tryagain = new LabyrinthTryAgain(_loc2_,false);
         PositionUtils.setPos(tryagain,"dt.labyrinth.LabyrinthFrame.TryAgainPos");
         tryagain.addEventListener("tryagain",__tryAgain);
         tryagain.addEventListener("giveup",__giveup);
         LayerManager.Instance.addToLayer(tryagain,3,false,2);
         hideLabyrinthFrame();
      }
      
      protected function __giveup(param1:GameEvent) : void
      {
         SocketManager.Instance.out.labyrinthTryAgain(againSelectType,false,param1.data);
         disposeTryAgain();
         _manager.model.tryAgainComplete = false;
      }
      
      protected function __tryAgain(param1:GameEvent) : void
      {
         SocketManager.Instance.out.labyrinthTryAgain(againSelectType,true,param1.data);
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
      
      protected function __sendStart(param1:Event) : void
      {
         GameInSocketOut.sendGameStart();
      }
      
      protected function __startLoading(param1:Event) : void
      {
         if(RoomManager.Instance.current && RoomManager.Instance.current.type == 15)
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
      
      protected function __onOpenView(param1:Event) : void
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
      
      protected function __labyrinthFrameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 1 || param1.responseCode == 0 || param1.responseCode == 4)
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
      
      public function loadRankingList(param1:int = 0) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["id"] = PlayerManager.Instance.Self.ID;
         _loc3_["rnd"] = Math.random();
         var _loc4_:String = "WarriorFamRankList.xml";
         if(param1 == 1)
         {
            _loc4_ = "WarriorHighFamRankList.xml";
         }
         var _loc2_:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath(_loc4_),2,_loc3_);
         _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingWarriorFamRankListFailure");
         _loc2_.analyzer = new RankingAnalyzer(openRankingFrame);
      }
      
      private function openRankingFrame(param1:RankingAnalyzer) : void
      {
         _manager.model.rankingList = param1.list;
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
      
      protected function __onProgress(param1:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
      }
      
      protected function __onUIModuleComplete(param1:UIModuleEvent) : void
      {
         if(param1.module == "labyrinth" || param1.module == "ddtshop")
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
      
      protected function __onClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
      }
   }
}
