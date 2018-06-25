package ddt.manager
{
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.utils.AssetModuleLoader;
   import ddtActivityIcon.DdtActivityIconManager;
   import ddtActivityIcon.DdtIconTxt;
   import flash.display.MovieClip;
   import flash.utils.getTimer;
   
   public class BattleGroudManager extends CoreManager
   {
      
      public static const BATTLE_OPENVIEW:String = "battleOpenView";
      
      private static var _instance:BattleGroudManager;
       
      
      private var _battleBtn:MovieClip;
      
      private var _lastCreatTime:int;
      
      private var _showModule:String = "";
      
      public var isShow:Boolean;
      
      private var _activityTxt:DdtIconTxt;
      
      public var initBattleIcon:Function;
      
      public var dispBattleIcon:Function;
      
      public function BattleGroudManager()
      {
         super();
      }
      
      public static function get Instance() : BattleGroudManager
      {
         if(!_instance)
         {
            _instance = new BattleGroudManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(132,1),open);
         SocketManager.Instance.addEventListener(PkgEvent.format(132,2),over);
      }
      
      public function __onBattleBtnHander() : void
      {
         SoundManager.instance.playButtonSound();
         var limitLev:int = ServerConfigManager.instance.trialBattleLevelLimit;
         if(PlayerManager.Instance.Self.Grade < limitLev)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",limitLev));
            return;
         }
         if(getTimer() - _lastCreatTime > 3000)
         {
            _lastCreatTime = getTimer();
            AssetModuleLoader.startCodeLoader(createBattleRoom);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wonderfulActivity.npc.clickTip"));
         }
      }
      
      private function createBattleRoom() : void
      {
         GameInSocketOut.sendCreateRoom(LanguageMgr.GetTranslation("ddt.battleRoom.roomName"),120,3);
      }
      
      private function playAllMc($mc:MovieClip) : void
      {
         var cMc:* = null;
         var index:int = 0;
         while($mc.numChildren - index)
         {
            if($mc.getChildAt(index) is MovieClip)
            {
               cMc = $mc.getChildAt(index) as MovieClip;
               cMc.play();
               playAllMc(cMc);
            }
            index++;
         }
      }
      
      private function stopAllMc($mc:MovieClip) : void
      {
         var cMc:* = null;
         var index:int = 0;
         while($mc.numChildren - index)
         {
            if($mc.getChildAt(index) is MovieClip)
            {
               cMc = $mc.getChildAt(index) as MovieClip;
               cMc.stop();
               stopAllMc(cMc);
            }
            index++;
         }
      }
      
      public function open(e:PkgEvent) : void
      {
         isShow = true;
         if(PlayerManager.Instance.Self.Grade >= 20)
         {
            if(initBattleIcon != null)
            {
               initBattleIcon();
            }
         }
      }
      
      public function over(e:PkgEvent) : void
      {
         isShow = false;
         DdtActivityIconManager.Instance.currObj = null;
      }
      
      public function onShow() : void
      {
         _showModule = "battleground";
         show();
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("battleOpenView",_showModule));
      }
   }
}
