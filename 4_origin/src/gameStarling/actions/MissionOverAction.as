package gameStarling.actions
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
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Player;
   import gameCommon.view.MissionOverInfoPanel;
   import gameStarling.view.map.MapView3D;
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
      
      private var _map:MapView3D;
      
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
      
      public function MissionOverAction(map:MapView3D, event:CrazyTankSocketEvent, func:Function, waitTime:Number = 3000)
      {
         super();
         _event = event;
         _map = map;
         _func = func;
         _count = waitTime / 40;
         readInfo(_event);
      }
      
      public static function getGradedStr(grade:int) : String
      {
         if(grade >= 3)
         {
            return "S";
         }
         if(grade >= 2)
         {
            return "A";
         }
         if(grade == 0)
         {
            return "C";
         }
         if(grade < 2)
         {
            return "B";
         }
         return "C";
      }
      
      private function readInfo(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var obj:* = null;
         var playerGainInfo:* = null;
         var player:* = null;
         var cardCount:int = 0;
         var playerCanGetCardCount:int = 0;
         var count:int = 0;
         var j:* = 0;
         var pkg:PackageIn = event.pkg;
         var current:GameInfo = GameControl.Instance.Current;
         current.missionInfo.missionOverPlayer = [];
         current.missionInfo.tackCardType = pkg.readInt();
         current.hasNextMission = pkg.readBoolean();
         if(current.hasNextMission)
         {
            current.missionInfo.pic = pkg.readUTF();
         }
         current.missionInfo.canEnterFinall = pkg.readBoolean();
         var playerCount:int = pkg.readInt();
         for(i = 0; i < playerCount; )
         {
            obj = {};
            playerGainInfo = new BaseSettleInfo();
            playerGainInfo.playerid = pkg.readInt();
            playerGainInfo.level = pkg.readInt();
            playerGainInfo.treatment = pkg.readInt();
            player = current.findGamerbyPlayerId(playerGainInfo.playerid);
            obj.gainGP = pkg.readInt();
            player.isWin = pkg.readBoolean();
            cardCount = pkg.readInt();
            playerCanGetCardCount = pkg.readInt();
            player.GetCardCount = playerCanGetCardCount;
            player.BossCardCount = playerCanGetCardCount;
            player.hasLevelAgain = pkg.readBoolean();
            player.hasGardGet = pkg.readBoolean();
            if(player.isWin)
            {
               if(cardCount == 0)
               {
                  obj.gameOverType = 0;
               }
               else if(cardCount == 1 && !current.hasNextMission)
               {
                  obj.gameOverType = 6;
               }
               else if(cardCount == 1 && current.hasNextMission)
               {
                  obj.gameOverType = 2;
               }
               else if(cardCount == 2 && current.hasNextMission)
               {
                  obj.gameOverType = 3;
               }
               else if(cardCount == 2 && !current.hasNextMission)
               {
                  obj.gameOverType = 4;
               }
               else
               {
                  obj.gameOverType = 0;
               }
            }
            else
            {
               obj.gameOverType = 5;
               if(RoomManager.Instance.current.type == 14)
               {
                  SocketManager.Instance.out.sendWorldBossRoomStauts(3);
                  WorldBossManager.Instance.setSelfStatus(3);
               }
            }
            player.expObj = obj;
            if(player.playerInfo.ID == current.selfGamePlayer.playerInfo.ID)
            {
               current.selfGamePlayer.BossCardCount = player.BossCardCount;
            }
            current.missionInfo.missionOverPlayer.push(playerGainInfo);
            i++;
         }
         if(current.selfGamePlayer.BossCardCount > 0)
         {
            count = pkg.readInt();
            current.missionInfo.missionOverNPCMovies = [];
            for(j = uint(0); j < count; )
            {
               current.missionInfo.missionOverNPCMovies.push(pkg.readUTF());
               j++;
            }
         }
         current.missionInfo.nextMissionIndex = current.missionInfo.missionIndex + 1;
      }
      
      override public function cancel() : void
      {
         _event.executed = true;
      }
      
      override public function execute() : void
      {
         var movie:* = null;
         var mc:* = null;
         if(RoomManager.Instance.current.selfRoomPlayer.isViewer)
         {
            _executed = true;
         }
         if(WeakGuildManager.Instance.switchUserGuide)
         {
            if(GameControl.Instance.Current.selfGamePlayer.isWin)
            {
               if(NewHandGuideManager.Instance.mapID == 111)
               {
                  NewHandQueue.Instance.push(new Step(11,exeExplainOne,preExplainOne,finExplainOne,0,true));
                  NewHandQueue.Instance.push(new Step(12,exeWin,preWin,finWin));
                  _isFinished = true;
                  return;
               }
               if(NewHandGuideManager.Instance.mapID == 112)
               {
                  NewHandQueue.Instance.push(new Step(25,exeExplainTen,preExplainTen,finExplainTen));
                  NewHandQueue.Instance.push(new Step(26,exeWin,preWin,finWinI));
                  NoviceDataManager.instance.saveNoviceData(430,PathManager.userName(),PathManager.solveRequestPath());
                  _isFinished = true;
                  return;
               }
               if(NewHandGuideManager.Instance.mapID == 113)
               {
                  NewHandQueue.Instance.push(new Step(31,exePowerThree,prePowerThree,finPowerThree));
                  NewHandQueue.Instance.push(new Step(32,exeWin,preWin,finWinI));
                  _isFinished = true;
                  return;
               }
               if(NewHandGuideManager.Instance.mapID == 114)
               {
                  NewHandQueue.Instance.push(new Step(43,exePlane,prePlane,finPlane));
                  NewHandQueue.Instance.push(new Step(44,exeWin,preWin,finWinI));
                  _isFinished = true;
                  return;
               }
               if(NewHandGuideManager.Instance.mapID == 115)
               {
                  NewHandQueue.Instance.push(new Step(52,exeTwoTwenty,preTwoTwenty,finTwoTwenty));
                  NewHandQueue.Instance.push(new Step(53,exeWin,preWin,finWinI));
                  _isFinished = true;
                  return;
               }
               if(NewHandGuideManager.Instance.mapID == 116)
               {
                  NewHandQueue.Instance.push(new Step(62,exeThreeFourFive,preThreeFourFive,finThreeFourFive));
                  NewHandQueue.Instance.push(new Step(63,exeWin,preWin,finWinI));
                  _isFinished = true;
                  return;
               }
            }
            else
            {
               switch(int(NewHandGuideManager.Instance.mapID) - 111)
               {
                  case 0:
                  case 1:
                  case 2:
                  case 3:
                  case 4:
                  case 5:
                     NewHandQueue.Instance.push(new Step(100,exeLost,preLost,finLost));
                     _isFinished = true;
                     return;
               }
            }
         }
         if(!_executed)
         {
            if(_map.hasSomethingMoving() == false && (_map.currentPlayer == null || _map.currentPlayer.actionCount == 0))
            {
               _executed = true;
               _event.executed = true;
               if(_map.currentPlayer)
               {
                  _map.currentPlayer.beginNewTurn();
               }
               infoPane = new MissionOverInfoPanel();
               upContextView(infoPane);
               if(StateManager.currentStateType == "fightLabGameView")
               {
                  FightLibManager.Instance.lastWin = GameControl.Instance.Current.selfGamePlayer.isWin;
               }
               if(GameControl.Instance.Current.selfGamePlayer.isWin)
               {
                  mc = ClassUtils.CreatInstance("asset.game.winAsset");
               }
               else
               {
                  mc = ClassUtils.CreatInstance("asset.game.lostAsset");
               }
               infoPane.x = 77;
               mc.addChild(infoPane);
               movie = new MovieClipWrapper(mc,true,true);
               SoundManager.instance.play("040");
               movie.movie.x = 500;
               movie.movie.y = 360;
               movie.addEventListener("complete",__complete);
               _map.gameView.addChild(movie.movie);
            }
         }
         else
         {
            _count = Number(_count) - 1;
            if(_count <= 0)
            {
               _func();
               _isFinished = true;
            }
         }
      }
      
      private function __explainEnter(evt:Event) : void
      {
         (evt.currentTarget as EventDispatcher).removeEventListener("explainEnter",__explainEnter);
         _clicked = true;
         if(_ten == evt.currentTarget)
         {
            NoviceDataManager.instance.saveNoviceData(440,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(_plane == evt.currentTarget)
         {
            NoviceDataManager.instance.saveNoviceData(630,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(_twoTwenty == evt.currentTarget)
         {
            NoviceDataManager.instance.saveNoviceData(790,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(_threeFourFive == evt.currentTarget)
         {
            NoviceDataManager.instance.saveNoviceData(970,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      private function preExplainOne() : void
      {
         NewHandContainer.Instance.showMovie("asset.trainer.pickOneMove");
      }
      
      private function exeExplainOne() : Boolean
      {
         _c = Number(_c) + 1;
         if(_c == 51)
         {
            _one = ComponentFactory.Instance.creatCustomObject("trainer.ExplainOne");
            _one.addEventListener("explainEnter",__explainEnter);
            _one.show();
         }
         else if(_c == 55)
         {
            NewHandContainer.Instance.hideMovie("asset.trainer.pickOneMove");
         }
         return _clicked;
      }
      
      private function finExplainOne() : void
      {
         _one.dispose();
         _one = null;
      }
      
      private function preWin() : void
      {
         SoundManager.instance.stopMusic();
         SoundManager.instance.setMusicVolumeByRatio(2);
         _win = new MovieClipWrapper(ClassUtils.CreatInstance("asset.game.winAsset"),true,true);
         _win.movie.x = 500;
         _win.movie.y = 360;
         _map.gameView.addChild(_win.movie);
         SoundManager.instance.play("040");
      }
      
      private function exeWin() : Boolean
      {
         return _win.movie.currentFrame == _win.movie.totalFrames;
      }
      
      private function finWin() : void
      {
         StateManager.setState("main");
         _win = null;
         NewHandQueue.Instance.dispose();
      }
      
      private function preExplainTen() : void
      {
         _c = 0;
         _clicked = false;
         NewHandContainer.Instance.showMovie("asset.trainer.pickTenMove");
      }
      
      private function exeExplainTen() : Boolean
      {
         _c = Number(_c) + 1;
         if(_c == 51)
         {
            _ten = ComponentFactory.Instance.creatCustomObject("trainer.ExplainTen");
            _ten.addEventListener("explainEnter",__explainEnter);
            _ten.show();
         }
         else if(_c == 55)
         {
            NewHandContainer.Instance.hideMovie("asset.trainer.pickTenMove");
         }
         return _clicked;
      }
      
      private function finExplainTen() : void
      {
         _ten.dispose();
         _ten = null;
      }
      
      private function finWinI() : void
      {
         _win = null;
         NewHandQueue.Instance.dispose();
      }
      
      private function prePowerThree() : void
      {
         _c = 0;
         _clicked = false;
         NewHandContainer.Instance.showMovie("asset.trainer.getPowerThreeMove");
      }
      
      private function exePowerThree() : Boolean
      {
         _c = Number(_c) + 1;
         if(_c == 51)
         {
            _powerThree = ComponentFactory.Instance.creatCustomObject("trainer.ExplainPowerThree");
            _powerThree.addEventListener("explainEnter",__explainEnter);
            _powerThree.show();
         }
         else if(_c == 55)
         {
            NewHandContainer.Instance.hideMovie("asset.trainer.getPowerThreeMove");
         }
         return _clicked;
      }
      
      private function finPowerThree() : void
      {
         _powerThree.dispose();
         _powerThree = null;
      }
      
      private function prePlane() : void
      {
         _c = 0;
         _clicked = false;
         NewHandContainer.Instance.showMovie("asset.trainer.pickPlaneMove");
      }
      
      private function exePlane() : Boolean
      {
         _c = Number(_c) + 1;
         if(_c == 64)
         {
            NewHandContainer.Instance.hideMovie("asset.trainer.pickPlaneMove");
            _plane = ComponentFactory.Instance.creatCustomObject("trainer.ExplainPlane");
            _plane.addEventListener("explainEnter",__explainEnter);
            _plane.show();
         }
         return _clicked;
      }
      
      private function finPlane() : void
      {
         _plane.dispose();
         _plane = null;
      }
      
      private function preTwoTwenty() : void
      {
         _c = 0;
         _clicked = false;
         NewHandContainer.Instance.showMovie("asset.trainer.getTwoTwentyMove");
      }
      
      private function exeTwoTwenty() : Boolean
      {
         _c = Number(_c) + 1;
         if(_c == 51)
         {
            _twoTwenty = ComponentFactory.Instance.creatCustomObject("trainer.ExplainTwoTwenty");
            _twoTwenty.addEventListener("explainEnter",__explainEnter);
            _twoTwenty.show();
         }
         else if(_c == 55)
         {
            NewHandContainer.Instance.hideMovie("asset.trainer.getTwoTwentyMove");
         }
         return _clicked;
      }
      
      private function finTwoTwenty() : void
      {
         _twoTwenty.dispose();
         _twoTwenty = null;
      }
      
      private function preThreeFourFive() : void
      {
         _c = 0;
         _clicked = false;
         NewHandContainer.Instance.showMovie("asset.trainer.getThreeFourFiveMove");
      }
      
      private function exeThreeFourFive() : Boolean
      {
         _c = Number(_c) + 1;
         if(_c == 51)
         {
            _threeFourFive = ComponentFactory.Instance.creatCustomObject("trainer.ExplainThreeFourFive");
            _threeFourFive.addEventListener("explainEnter",__explainEnter);
            _threeFourFive.show();
         }
         else if(_c == 55)
         {
            NewHandContainer.Instance.hideMovie("asset.trainer.getThreeFourFiveMove");
         }
         return _clicked;
      }
      
      private function finThreeFourFive() : void
      {
         _threeFourFive.dispose();
         _threeFourFive = null;
      }
      
      private function preLost() : void
      {
         _lost = new MovieClipWrapper(ClassUtils.CreatInstance("asset.game.lostAsset"),true,true);
         _lost.movie.x = 500;
         _lost.movie.y = 360;
         _map.gameView.addChild(_lost.movie);
         SoundManager.instance.play("040");
      }
      
      private function exeLost() : Boolean
      {
         return _lost.movie.currentFrame == _lost.movie.totalFrames;
      }
      
      private function finLost() : void
      {
         _lost = null;
         NewHandQueue.Instance.dispose();
      }
      
      private function __complete(event:Event) : void
      {
         MovieClipWrapper(event.target).removeEventListener("complete",__complete);
         infoPane.dispose();
         infoPane = null;
      }
      
      private function upContextView(mc:MissionOverInfoPanel) : void
      {
         var info:MissionInfo = GameControl.Instance.Current.missionInfo;
         var gameOverInfo:BaseSettleInfo = GameControl.Instance.Current.missionInfo.findMissionOverInfo(PlayerManager.Instance.Self.ID);
         mc.titleTxt1.text = LanguageMgr.GetTranslation("tank.game.actions.kill");
         mc.valueTxt1.text = String(info.currentValue2);
         mc.titleTxt2.text = LanguageMgr.GetTranslation("tank.game.actions.turn");
         mc.valueTxt2.text = String(info.currentValue1);
         mc.titleTxt3.text = LanguageMgr.GetTranslation("tank.game.BloodStrip.HP");
         mc.valueTxt3.text = String(gameOverInfo.treatment);
      }
   }
}
