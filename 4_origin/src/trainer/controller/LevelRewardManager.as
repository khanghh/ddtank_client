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
      
      public function LevelRewardManager()
      {
         super();
      }
      
      public static function get Instance() : LevelRewardManager
      {
         if(_instance == null)
         {
            _instance = new LevelRewardManager();
         }
         return _instance;
      }
      
      public function get isShow() : Boolean
      {
         return _isShow;
      }
      
      public function set isShow(value:Boolean) : void
      {
         _isShow = value;
      }
      
      public function setup() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.getLevelRewardPath(),2);
         loader.loadErrorMessage = "load levelRewards Failed";
         loader.analyzer = new LevelRewardAnalyzer(onDataComplete);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function onDataComplete(analyzer:LevelRewardAnalyzer) : void
      {
         if(!WeakGuildManager.Instance.switchUserGuide || PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            return;
         }
         _reward = analyzer.list;
         PlayerManager.Instance.Self.addEventListener("propertychange",__onChange);
      }
      
      private function __onChange(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Grade"] && PlayerManager.Instance.Self.IsUpGrade)
         {
            if(PlayerManager.Instance.Self.Grade == 6)
            {
               new HelperUIModuleLoad().loadUIModule(["trainerui"],showSecFrame);
            }
            SocketManager.Instance.out.sendExpBlessedData();
         }
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         hide();
      }
      
      public function getRewardInfo(level:int, sort:int) : LevelRewardInfo
      {
         return _reward[level][sort];
      }
      
      public function showSecFrame() : void
      {
         if(!WeakGuildManager.Instance.switchUserGuide || PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            return;
         }
         var secFr:SecondOnlineView = ComponentFactory.Instance.creat("trainer.second.mainFrame");
         if(CacheSysManager.isLock("alertInFight"))
         {
            CacheSysManager.getInstance().cache("alertInFight",new AlertAction(secFr,4,2));
         }
         else
         {
            secFr.show();
         }
      }
      
      public function showFrame(level:int) : void
      {
         if(!WeakGuildManager.Instance.switchUserGuide || PlayerManager.Instance.Self.Grade == 1 || PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            return;
         }
         _fr = ComponentFactory.Instance.creatCustomObject("trainer.welcome.levelRewardFrame");
         _fr.addEventListener("response",__onResponse);
         if(CacheSysManager.isLock("alertInFight"))
         {
            _fr.level = level;
            CacheSysManager.getInstance().cache("alertInFight",new AlertAction(_fr,4,2));
         }
         else
         {
            _fr.level = level;
            _fr.show(level);
            isShow = true;
         }
      }
      
      public function hide() : void
      {
         if(_fr)
         {
            _fr.removeEventListener("response",__onResponse);
            _fr.hide();
            _fr = null;
            isShow = false;
         }
      }
   }
}
