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
      
      public function MissionOverAction(param1:MapView, param2:CrazyTankSocketEvent, param3:Function, param4:Number = 3000)
      {
         super();
         _event = param2;
         _map = param1;
         _func = param3;
         _count = param4 / 40;
         readInfo(_event);
      }
      
      public static function getGradedStr(param1:int) : String
      {
         if(param1 >= 3)
         {
            return "S";
         }
         if(param1 >= 2)
         {
            return "A";
         }
         if(param1 == 0)
         {
            return "C";
         }
         if(param1 < 2)
         {
            return "B";
         }
         return "C";
      }
      
      private function readInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc12_:int = 0;
         var _loc9_:* = null;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc10_:* = 0;
         var _loc8_:PackageIn = param1.pkg;
         var _loc7_:GameInfo = GameControl.Instance.Current;
         _loc7_.missionInfo.missionOverPlayer = [];
         _loc7_.missionInfo.tackCardType = _loc8_.readInt();
         _loc7_.hasNextMission = _loc8_.readBoolean();
         if(_loc7_.hasNextMission)
         {
            _loc7_.missionInfo.pic = _loc8_.readUTF();
         }
         _loc7_.missionInfo.canEnterFinall = _loc8_.readBoolean();
         var _loc11_:int = _loc8_.readInt();
         _loc12_ = 0;
         while(_loc12_ < _loc11_)
         {
            _loc9_ = {};
            _loc6_ = new BaseSettleInfo();
            _loc6_.playerid = _loc8_.readInt();
            _loc6_.level = _loc8_.readInt();
            _loc6_.treatment = _loc8_.readInt();
            _loc4_ = _loc7_.findGamerbyPlayerId(_loc6_.playerid);
            _loc9_.gainGP = _loc8_.readInt();
            _loc4_.isWin = _loc8_.readBoolean();
            _loc5_ = _loc8_.readInt();
            _loc2_ = _loc8_.readInt();
            _loc4_.GetCardCount = _loc2_;
            _loc4_.BossCardCount = _loc2_;
            _loc4_.hasLevelAgain = _loc8_.readBoolean();
            _loc4_.hasGardGet = _loc8_.readBoolean();
            if(_loc4_.isWin)
            {
               if(_loc5_ == 0)
               {
                  _loc9_.gameOverType = 0;
               }
               else if(_loc5_ == 1 && !_loc7_.hasNextMission)
               {
                  _loc9_.gameOverType = 6;
               }
               else if(_loc5_ == 1 && _loc7_.hasNextMission)
               {
                  _loc9_.gameOverType = 2;
               }
               else if(_loc5_ == 2 && _loc7_.hasNextMission)
               {
                  _loc9_.gameOverType = 3;
               }
               else if(_loc5_ == 2 && !_loc7_.hasNextMission)
               {
                  _loc9_.gameOverType = 4;
               }
               else
               {
                  _loc9_.gameOverType = 0;
               }
            }
            else
            {
               _loc9_.gameOverType = 5;
               if(RoomManager.Instance.current.type == 14)
               {
                  SocketManager.Instance.out.sendWorldBossRoomStauts(3);
                  WorldBossManager.Instance.setSelfStatus(3);
               }
            }
            _loc4_.expObj = _loc9_;
            if(_loc4_.playerInfo.ID == _loc7_.selfGamePlayer.playerInfo.ID)
            {
               _loc7_.selfGamePlayer.BossCardCount = _loc4_.BossCardCount;
            }
            _loc7_.missionInfo.missionOverPlayer.push(_loc6_);
            _loc12_++;
         }
         if(_loc7_.selfGamePlayer.BossCardCount > 0)
         {
            _loc3_ = _loc8_.readInt();
            _loc7_.missionInfo.missionOverNPCMovies = [];
            _loc10_ = uint(0);
            while(_loc10_ < _loc3_)
            {
               _loc7_.missionInfo.missionOverNPCMovies.push(_loc8_.readUTF());
               _loc10_++;
            }
         }
         _loc7_.missionInfo.nextMissionIndex = _loc7_.missionInfo.missionIndex + 1;
      }
      
      override public function cancel() : void
      {
         _event.executed = true;
      }
      
      override public function execute() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
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
                  _loc1_ = ClassUtils.CreatInstance("asset.game.winAsset");
               }
               else
               {
                  _loc1_ = ClassUtils.CreatInstance("asset.game.lostAsset");
               }
               infoPane.x = 77;
               _loc1_.addChild(infoPane);
               _loc2_ = new MovieClipWrapper(_loc1_,true,true);
               SoundManager.instance.play("040");
               _loc2_.movie.x = 500;
               _loc2_.movie.y = 360;
               _loc2_.addEventListener("complete",__complete);
               _map.gameView.addChild(_loc2_.movie);
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
      
      private function __explainEnter(param1:Event) : void
      {
         (param1.currentTarget as EventDispatcher).removeEventListener("explainEnter",__explainEnter);
         _clicked = true;
         if(_ten == param1.currentTarget)
         {
            NoviceDataManager.instance.saveNoviceData(440,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(_plane == param1.currentTarget)
         {
            NoviceDataManager.instance.saveNoviceData(630,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(_twoTwenty == param1.currentTarget)
         {
            NoviceDataManager.instance.saveNoviceData(790,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(_threeFourFive == param1.currentTarget)
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
      
      private function __complete(param1:Event) : void
      {
         MovieClipWrapper(param1.target).removeEventListener("complete",__complete);
         infoPane.dispose();
         infoPane = null;
      }
      
      private function upContextView(param1:MissionOverInfoPanel) : void
      {
         var _loc3_:MissionInfo = GameControl.Instance.Current.missionInfo;
         var _loc2_:BaseSettleInfo = GameControl.Instance.Current.missionInfo.findMissionOverInfo(PlayerManager.Instance.Self.ID);
         param1.titleTxt1.text = LanguageMgr.GetTranslation("tank.game.actions.kill");
         param1.valueTxt1.text = String(_loc3_.currentValue2);
         param1.titleTxt2.text = LanguageMgr.GetTranslation("tank.game.actions.turn");
         param1.valueTxt2.text = String(_loc3_.currentValue1);
         param1.titleTxt3.text = LanguageMgr.GetTranslation("tank.game.BloodStrip.HP");
         param1.valueTxt3.text = String(_loc2_.treatment);
      }
   }
}
