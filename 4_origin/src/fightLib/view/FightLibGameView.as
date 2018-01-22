package fightLib.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.states.BaseStateView;
   import fightLib.FightLibControl;
   import fightLib.FightLibManager;
   import fightLib.script.BaseScript;
   import fightLib.script.HighGap.DifficultHighGap;
   import fightLib.script.HighGap.EasyHighGap;
   import fightLib.script.HighGap.NormalHighGap;
   import fightLib.script.HighThrow.DifficultHighThrow;
   import fightLib.script.HighThrow.EasyHighThrow;
   import fightLib.script.HighThrow.NormalHighThrow;
   import fightLib.script.MeasureScree.DifficultMeasureScreenScript;
   import fightLib.script.MeasureScree.EasyMeasureScreenScript;
   import fightLib.script.MeasureScree.NomalMeasureScreenScript;
   import fightLib.script.SixtyDegree.DifficultSixtyDegreeScript;
   import fightLib.script.SixtyDegree.EasySixtyDegreeScript;
   import fightLib.script.SixtyDegree.NormalSixtyDegreeScript;
   import fightLib.script.TwentyDegree.DifficultTwentyDegree;
   import fightLib.script.TwentyDegree.EasyTwentyDegree;
   import fightLib.script.TwentyDegree.NormalTwentyDegree;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import game.view.GameView;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameCommon.view.DungeonHelpView;
   import gameCommon.view.DungeonInfoView;
   import gameCommon.view.smallMap.SmallLiving;
   import road7th.comm.PackageIn;
   
   public class FightLibGameView extends GameView
   {
       
      
      private var _script:BaseScript;
      
      private var _frame:FightLibQuestionFrame;
      
      private var _redPoint:Sprite;
      
      private var _shouldShowTurn:Boolean = true;
      
      private var _isWaittingToAttack:Boolean = false;
      
      private var _scriptStarted:Boolean;
      
      private var _powerTable:MovieClip;
      
      private var _guildMc:MovieClip;
      
      private var _lessonLiving:SmallLiving;
      
      public function FightLibGameView()
      {
         super();
      }
      
      override public function getType() : String
      {
         return "fightLabGameView";
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         initScript();
         closeShowTurn();
         blockFly();
         GameControl.Instance.Current.selfGamePlayer.lockProp = true;
         setPropBarClickEnable(false,true);
         arrowHammerEnable = false;
         blockHammer();
         pauseGame();
         _map.smallMap.setHardLevel(FightLibManager.Instance.currentInfo.difficulty,1);
         _powerTable = ComponentFactory.Instance.creat("tank.fightLib.FightLibPowerTableAsset");
         initEvents();
      }
      
      private function initEvents() : void
      {
         SocketManager.Instance.addEventListener("popupQuestionFrame",__popupQuestionFrame);
      }
      
      private function removeEvents() : void
      {
         SocketManager.Instance.removeEventListener("popupQuestionFrame",__popupQuestionFrame);
         StageReferance.stage.removeEventListener("mouseUp",__downHandler);
      }
      
      override protected function gameOver() : void
      {
         super.gameOver();
         FightLibControl.Instance.lastFightLibMission = PlayerManager.Instance.Self.fightLibMission;
         FightLibManager.Instance.lastInfo = FightLibManager.Instance.currentInfo;
         FightLibManager.Instance.currentInfo = null;
      }
      
      override public function updateControlBarState(param1:Living) : void
      {
         setPropBarClickEnable(false,true);
      }
      
      private function __reAnswer(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         GameInSocketOut.sendFightLibReanswer();
         FightLibManager.Instance.reAnswerNum--;
      }
      
      private function __viewTutorial(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         FightLibControl.Instance.script.restart();
         GameInSocketOut.sendClientScriptStart();
         closeShowTurn();
         if(_frame)
         {
            _frame.close();
         }
      }
      
      private function initScript() : void
      {
         if(FightLibManager.Instance.currentInfo.id == 1000)
         {
            if(FightLibManager.Instance.currentInfo.difficulty == 0)
            {
               _script = new EasyMeasureScreenScript(this);
            }
            else if(FightLibManager.Instance.currentInfo.difficulty == 1)
            {
               _script = new NomalMeasureScreenScript(this);
            }
            else if(FightLibManager.Instance.currentInfo.difficulty == 2)
            {
               _script = new DifficultMeasureScreenScript(this);
            }
         }
         else if(FightLibManager.Instance.currentInfo.id == 1001)
         {
            if(FightLibManager.Instance.currentInfo.difficulty == 0)
            {
               _script = new EasyTwentyDegree(this);
            }
            else if(FightLibManager.Instance.currentInfo.difficulty == 1)
            {
               _script = new NormalTwentyDegree(this);
            }
            else if(FightLibManager.Instance.currentInfo.difficulty == 2)
            {
               _script = new DifficultTwentyDegree(this);
            }
         }
         else if(FightLibManager.Instance.currentInfo.id == 1002)
         {
            if(FightLibManager.Instance.currentInfo.difficulty == 0)
            {
               _script = new EasySixtyDegreeScript(this);
            }
            else if(FightLibManager.Instance.currentInfo.difficulty == 1)
            {
               _script = new NormalSixtyDegreeScript(this);
            }
            else if(FightLibManager.Instance.currentInfo.difficulty == 2)
            {
               _script = new DifficultSixtyDegreeScript(this);
            }
         }
         else if(FightLibManager.Instance.currentInfo.id == 1003)
         {
            if(FightLibManager.Instance.currentInfo.difficulty == 0)
            {
               _script = new EasyHighThrow(this);
            }
            else if(FightLibManager.Instance.currentInfo.difficulty == 1)
            {
               _script = new NormalHighThrow(this);
            }
            else if(FightLibManager.Instance.currentInfo.difficulty == 2)
            {
               _script = new DifficultHighThrow(this);
            }
         }
         else if(FightLibManager.Instance.currentInfo.id == 1004)
         {
            if(FightLibManager.Instance.currentInfo.difficulty == 0)
            {
               _script = new EasyHighGap(this);
            }
            else if(FightLibManager.Instance.currentInfo.difficulty == 1)
            {
               _script = new NormalHighGap(this);
            }
            else if(FightLibManager.Instance.currentInfo.difficulty == 2)
            {
               _script = new DifficultHighGap(this);
            }
         }
         FightLibControl.Instance.script = _script;
      }
      
      public function drawMasks() : void
      {
         if(!_tipLayers)
         {
            _tipLayers = new Sprite();
            addChild(_tipLayers);
         }
         _tipLayers.graphics.clear();
         _tipLayers.graphics.beginFill(0,0.8);
         _tipLayers.graphics.drawRect(-10,-10,828,820);
         _tipLayers.graphics.drawRect(818,122,200,690);
         _tipLayers.graphics.endFill();
      }
      
      public function pauseGame() : void
      {
         closeShowTurn();
      }
      
      public function continueGame() : void
      {
         _map.smallMap.titleBar.addEventListener("DungeonHelpChanged",__dungeonVisibleChanged);
         _barrier = new DungeonInfoView(_map.smallMap.titleBar.turnButton,this);
         _barrier.addEventListener("DungeonHelpVisibleChanged",__dungeonHelpChanged);
         _barrier.addEventListener("updateSmallMapView",__updateSmallMapView);
         _missionHelp = new DungeonHelpView(_map.smallMap.titleBar.turnButton,_barrier,this);
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("asset.game.DungeonHelpViewPos");
         _missionHelp.x = _loc1_.x;
         _missionHelp.y = _loc1_.y;
         addChild(_missionHelp);
         setTimeout(openShowTurn,3000);
      }
      
      public function moveToPlayer() : void
      {
         _map.smallMap.moveToPlayer();
      }
      
      public function splitSmallMapDrager() : void
      {
         _map.smallMap.showSpliter();
      }
      
      public function hideSmallMapSplit() : void
      {
         _map.smallMap.hideSpliter();
      }
      
      public function restoreText() : void
      {
         _map.smallMap.restoreText();
         if(getChildIndex(_map.smallMap) > getChildIndex(ChatManager.Instance.view))
         {
            swapChildren(_map.smallMap,ChatManager.Instance.view);
         }
      }
      
      public function shineText() : void
      {
         if(!_guildMc)
         {
            _guildMc = ComponentFactory.Instance.creat("tank.fightLib.GuildMc");
            addChild(_guildMc);
         }
         _guildMc.gotoAndStop("Stand");
         _guildMc.scaleX = 0.14;
         _guildMc.scaleY = 0.14;
         _guildMc.x = 899;
         _guildMc.y = 75;
         TweenLite.to(_guildMc,2,{
            "x":500,
            "y":298,
            "scaleX":1,
            "scaleY":1,
            "onComplete":ScaleCompleteHandler
         });
      }
      
      private function ScaleCompleteHandler() : void
      {
         TweenLite.to(_guildMc,2,{"onComplete":StartPlayHandler});
      }
      
      private function StartPlayHandler() : void
      {
         _guildMc.gotoAndPlay("guild_1");
      }
      
      private function GuildEndHandler() : void
      {
         removeChild(_guildMc);
         _guildMc = null;
      }
      
      public function shineText2() : void
      {
         _guildMc.gotoAndPlay("guild_2");
         addEventListener("enterFrame",onMoviePlay);
      }
      
      private function onMoviePlay(param1:Event) : void
      {
         if(_guildMc.currentLabel == "end")
         {
            _guildMc.gotoAndStop("end");
            removeEventListener("enterFrame",onMoviePlay);
            TweenLite.to(_guildMc,1,{
               "x":899,
               "y":75,
               "scaleX":0.14,
               "scaleY":0.14,
               "onComplete":GuildEndHandler
            });
         }
      }
      
      public function screanAddEvent() : void
      {
         StageReferance.stage.addEventListener("mouseUp",__downHandler);
      }
      
      private function __downHandler(param1:MouseEvent) : void
      {
         if(!_map.smallMap.__StartDrag)
         {
            return;
         }
         var _loc3_:int = _map.smallMap.screen.x;
         var _loc5_:int = _map.smallMap.screenX;
         var _loc4_:int = _map.smallMap.screen.y;
         var _loc2_:int = _map.smallMap.screenY;
         if(_loc3_ == _loc5_ && _loc4_ == _loc2_)
         {
            return;
         }
         StageReferance.stage.removeEventListener("mouseUp",__downHandler);
         _script.continueScript();
      }
      
      override protected function __playerChange(param1:CrazyTankSocketEvent) : void
      {
         if(!_scriptStarted)
         {
            _script.start();
            _scriptStarted = true;
         }
         if(_shouldShowTurn)
         {
            super.__playerChange(param1);
         }
      }
      
      public function clearMask() : void
      {
         _tipLayers.graphics.clear();
      }
      
      public function sendClientScriptStart() : void
      {
         GameInSocketOut.sendClientScriptStart();
      }
      
      public function sendClientScriptEnd() : void
      {
         GameInSocketOut.sendClientScriptEnd();
      }
      
      private function __popupQuestionFrame(param1:CrazyTankSocketEvent) : void
      {
         var _loc9_:int = 0;
         var _loc12_:int = 0;
         var _loc3_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:int = 0;
         var _loc11_:* = null;
         var _loc13_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc5_:Boolean = _loc4_.readBoolean();
         if(_loc5_)
         {
            _loc9_ = _loc4_.readInt();
            _loc12_ = _loc4_.readInt();
            _loc3_ = _loc4_.readInt();
            _loc10_ = _loc4_.readInt();
            _loc2_ = _loc4_.readInt();
            _loc11_ = _loc4_.readUTF();
            _loc13_ = _loc4_.readUTF();
            _loc6_ = _loc4_.readUTF();
            _loc8_ = _loc4_.readUTF();
            _loc7_ = _loc4_.readUTF();
            if(_frame)
            {
               _frame.close();
            }
            _frame = ComponentFactory.Instance.creatCustomObject("fightLib.view.FightLibQuestionFrame",[_loc9_,_loc11_,_loc12_,_loc3_,_loc10_,_loc13_,_loc6_,_loc8_,_loc7_,_loc2_]);
            _frame.show();
         }
         else if(_frame)
         {
            _frame.close();
         }
      }
      
      public function addRedPointInSmallMap() : void
      {
         _lessonLiving = new SmallLiving();
         _map.smallMap.addObj(_lessonLiving);
         _map.smallMap.updatePos(_lessonLiving,new Point(GameControl.Instance.Current.selfGamePlayer.pos.x + 1000,GameControl.Instance.Current.selfGamePlayer.pos.y));
      }
      
      public function removeRedPointInSmallMap() : void
      {
         if(_lessonLiving)
         {
            _map.smallMap.removeObj(_lessonLiving);
            _redPoint = null;
         }
      }
      
      public function leftJustifyWithPlayer() : void
      {
         _map.setCenter(_selfGamePlayer.pos.x + 500,_selfGamePlayer.pos.y,false);
      }
      
      public function leftJustifyWithRedPoint() : void
      {
         _map.setCenter(_selfGamePlayer.pos.x + 1500,_selfGamePlayer.pos.y,false);
      }
      
      override public function addliving(param1:CrazyTankSocketEvent) : void
      {
         super.addliving(param1);
         if(_isWaittingToAttack)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _gameInfo.livings;
            for each(var _loc2_ in _gameInfo.livings)
            {
               if(!(_loc2_ is Player))
               {
                  _loc2_.addEventListener("die",continueScript);
               }
            }
         }
      }
      
      public function waitAttack() : void
      {
         _isWaittingToAttack = true;
      }
      
      public function continueScript(param1:LivingEvent) : void
      {
         if(FightLibManager.Instance.isWork == true)
         {
            SocketManager.Instance.out.createMonster();
            return;
         }
         _isWaittingToAttack = false;
         var _loc4_:int = 0;
         var _loc3_:* = _gameInfo.livings;
         for each(var _loc2_ in _gameInfo.livings)
         {
            if(!(_loc2_ is Player))
            {
               _loc2_.removeEventListener("die",continueScript);
            }
         }
         _script.continueScript();
      }
      
      public function closeShowTurn() : void
      {
         _shouldShowTurn = false;
      }
      
      public function openShowTurn() : void
      {
         _shouldShowTurn = true;
      }
      
      public function enableReanswerBtn() : void
      {
      }
      
      public function blockFly() : void
      {
      }
      
      public function blockSmallMap() : void
      {
         _map.smallMap.allowDrag = false;
      }
      
      public function blockExist() : void
      {
         _map.smallMap.enableExit = false;
      }
      
      public function enableExist() : void
      {
         _map.smallMap.enableExit = true;
      }
      
      public function activeSmallMap() : void
      {
         _map.smallMap.allowDrag = true;
      }
      
      public function skip() : void
      {
         GameInSocketOut.sendGameSkipNext(1);
      }
      
      public function showPowerTable1() : void
      {
         _powerTable = ComponentFactory.Instance.creat("tank.fightLib.FightLibPowerTableAsset");
         _powerTable.y = 70;
         _powerTable.gotoAndStop(1);
         addChild(_powerTable);
      }
      
      public function showPowerTable2() : void
      {
         _powerTable = ComponentFactory.Instance.creat("tank.fightLib.FightLibPowerTableAsset");
         _powerTable.y = 70;
         _powerTable.gotoAndStop(2);
         addChild(_powerTable);
      }
      
      public function showPowerTable3() : void
      {
         _powerTable = ComponentFactory.Instance.creat("tank.fightLib.FightLibPowerTableAsset");
         _powerTable.y = 70;
         _powerTable.gotoAndStop(3);
         addChild(_powerTable);
      }
      
      public function hidePowerTable() : void
      {
         if(_powerTable && contains(_powerTable))
         {
            removeChild(_powerTable);
         }
         _powerTable = null;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         super.dispose();
         _loc1_ = LayerManager.Instance.getLayerByType(1).numChildren;
         while(_loc1_ > 0)
         {
            LayerManager.Instance.getLayerByType(1).removeChildAt(0);
            _loc1_--;
         }
         removeEvents();
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
         if(_powerTable)
         {
            ObjectUtils.disposeObject(_powerTable);
            _powerTable = null;
         }
         if(_redPoint)
         {
            ObjectUtils.disposeObject(_redPoint);
            _redPoint = null;
         }
         if(_guildMc)
         {
            TweenLite.killTweensOf(_guildMc,false);
            ObjectUtils.disposeObject(_guildMc);
            _guildMc = null;
         }
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         _scriptStarted = false;
         _isWaittingToAttack = false;
         SocketManager.Instance.removeEventListener("popupQuestionFrame",__popupQuestionFrame);
         StageReferance.stage.removeEventListener("mouseUp",__downHandler);
         var _loc4_:int = 0;
         var _loc3_:* = _gameInfo.livings;
         for each(var _loc2_ in _gameInfo.livings)
         {
            if(!(_loc2_ is Player))
            {
               _loc2_.removeEventListener("die",continueScript);
            }
         }
         if(_frame)
         {
            if(_frame.parent)
            {
               _frame.dispose();
            }
            _frame = null;
         }
         if(_powerTable)
         {
            if(_powerTable.parent)
            {
               _powerTable.parent.removeChild(_powerTable);
            }
            _powerTable = null;
         }
         if(_script)
         {
            _script.dispose();
            _script = null;
         }
         super.leaving(param1);
         GameControl.Instance.reset();
      }
   }
}
