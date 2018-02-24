package game.actions
{
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import ddt.data.map.MissionInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import fightLib.FightLibManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import game.model.BaseSettleInfo;
   import game.view.map.MapView;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Player;
   import gameCommon.view.MissionOverInfoPanel;
   import road7th.comm.PackageIn;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   import trainer.controller.NewHandGuideManager;
   import trainer.controller.NewHandQueue;
   import trainer.controller.WeakGuildManager;
   import trainer.data.Step;
   import trainer.view.ExplainOne;
   import trainer.view.ExplainPlane;
   import trainer.view.ExplainPowerThree;
   import trainer.view.ExplainTen;
   import trainer.view.ExplainThreeFourFive;
   import trainer.view.ExplainTwoTwenty;
   import trainer.view.NewHandContainer;
   import worldboss.WorldBossManager;
   
   public class MissionOverAction extends BaseAction
   {
       
      
      private var _event:CrazyTankSocketEvent;
      
      private var _executed:Boolean;
      
      private var _count:int;
      
      private var _map:MapView;
      
      private var _func:Function;
      
      private var infoPane:MissionOverInfoPanel;
      
      private var _clicked:Boolean;
      
      private var _c:int;
      
      private var _one:ExplainOne;
      
      private var _win:MovieClipWrapper;
      
      private var _ten:ExplainTen;
      
      private var _powerThree:ExplainPowerThree;
      
      private var _plane:ExplainPlane;
      
      private var _twoTwenty:ExplainTwoTwenty;
      
      private var _threeFourFive:ExplainThreeFourFive;
      
      private var _lost:MovieClipWrapper;
      
      public function MissionOverAction(param1:MapView, param2:CrazyTankSocketEvent, param3:Function, param4:Number = 3000){super();}
      
      public static function getGradedStr(param1:int) : String{return null;}
      
      private function readInfo(param1:CrazyTankSocketEvent) : void{}
      
      override public function cancel() : void{}
      
      override public function execute() : void{}
      
      private function __explainEnter(param1:Event) : void{}
      
      private function preExplainOne() : void{}
      
      private function exeExplainOne() : Boolean{return false;}
      
      private function finExplainOne() : void{}
      
      private function preWin() : void{}
      
      private function exeWin() : Boolean{return false;}
      
      private function finWin() : void{}
      
      private function preExplainTen() : void{}
      
      private function exeExplainTen() : Boolean{return false;}
      
      private function finExplainTen() : void{}
      
      private function finWinI() : void{}
      
      private function prePowerThree() : void{}
      
      private function exePowerThree() : Boolean{return false;}
      
      private function finPowerThree() : void{}
      
      private function prePlane() : void{}
      
      private function exePlane() : Boolean{return false;}
      
      private function finPlane() : void{}
      
      private function preTwoTwenty() : void{}
      
      private function exeTwoTwenty() : Boolean{return false;}
      
      private function finTwoTwenty() : void{}
      
      private function preThreeFourFive() : void{}
      
      private function exeThreeFourFive() : Boolean{return false;}
      
      private function finThreeFourFive() : void{}
      
      private function preLost() : void{}
      
      private function exeLost() : Boolean{return false;}
      
      private function finLost() : void{}
      
      private function __complete(param1:Event) : void{}
      
      private function upContextView(param1:MissionOverInfoPanel) : void{}
   }
}
