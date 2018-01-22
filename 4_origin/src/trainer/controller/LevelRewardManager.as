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
      
      public function set isShow(param1:Boolean) : void
      {
         _isShow = param1;
      }
      
      public function setup() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.getLevelRewardPath(),2);
         _loc1_.loadErrorMessage = "load levelRewards Failed";
         _loc1_.analyzer = new LevelRewardAnalyzer(onDataComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function onDataComplete(param1:LevelRewardAnalyzer) : void
      {
         if(!WeakGuildManager.Instance.switchUserGuide || PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            return;
         }
         _reward = param1.list;
         PlayerManager.Instance.Self.addEventListener("propertychange",__onChange);
      }
      
      private function __onChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Grade"] && PlayerManager.Instance.Self.IsUpGrade)
         {
            if(PlayerManager.Instance.Self.Grade == 6)
            {
               new HelperUIModuleLoad().loadUIModule(["trainerui"],showSecFrame);
            }
            SocketManager.Instance.out.sendExpBlessedData();
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         hide();
      }
      
      public function getRewardInfo(param1:int, param2:int) : LevelRewardInfo
      {
         return _reward[param1][param2];
      }
      
      public function showSecFrame() : void
      {
         if(!WeakGuildManager.Instance.switchUserGuide || PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            return;
         }
         var _loc1_:SecondOnlineView = ComponentFactory.Instance.creat("trainer.second.mainFrame");
         if(CacheSysManager.isLock("alertInFight"))
         {
            CacheSysManager.getInstance().cache("alertInFight",new AlertAction(_loc1_,4,2));
         }
         else
         {
            _loc1_.show();
         }
      }
      
      public function showFrame(param1:int) : void
      {
         if(!WeakGuildManager.Instance.switchUserGuide || PlayerManager.Instance.Self.Grade == 1 || PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            return;
         }
         _fr = ComponentFactory.Instance.creatCustomObject("trainer.welcome.levelRewardFrame");
         _fr.addEventListener("response",__onResponse);
         if(CacheSysManager.isLock("alertInFight"))
         {
            _fr.level = param1;
            CacheSysManager.getInstance().cache("alertInFight",new AlertAction(_fr,4,2));
         }
         else
         {
            _fr.level = param1;
            _fr.show(param1);
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
