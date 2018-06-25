package fightLib.view{   import com.greensock.TweenLite;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.LivingEvent;   import ddt.manager.ChatManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.states.BaseStateView;   import fightLib.FightLibControl;   import fightLib.FightLibManager;   import fightLib.script.BaseScript;   import fightLib.script.HighGap.DifficultHighGap;   import fightLib.script.HighGap.EasyHighGap;   import fightLib.script.HighGap.NormalHighGap;   import fightLib.script.HighThrow.DifficultHighThrow;   import fightLib.script.HighThrow.EasyHighThrow;   import fightLib.script.HighThrow.NormalHighThrow;   import fightLib.script.MeasureScree.DifficultMeasureScreenScript;   import fightLib.script.MeasureScree.EasyMeasureScreenScript;   import fightLib.script.MeasureScree.NomalMeasureScreenScript;   import fightLib.script.SixtyDegree.DifficultSixtyDegreeScript;   import fightLib.script.SixtyDegree.EasySixtyDegreeScript;   import fightLib.script.SixtyDegree.NormalSixtyDegreeScript;   import fightLib.script.TwentyDegree.DifficultTwentyDegree;   import fightLib.script.TwentyDegree.EasyTwentyDegree;   import fightLib.script.TwentyDegree.NormalTwentyDegree;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.setTimeout;   import game.view.GameView;   import gameCommon.GameControl;   import gameCommon.model.Living;   import gameCommon.model.Player;   import gameCommon.view.DungeonHelpView;   import gameCommon.view.DungeonInfoView;   import gameCommon.view.smallMap.SmallLiving;   import road7th.comm.PackageIn;      public class FightLibGameView extends GameView   {                   private var _script:BaseScript;            private var _frame:FightLibQuestionFrame;            private var _redPoint:Sprite;            private var _shouldShowTurn:Boolean = true;            private var _isWaittingToAttack:Boolean = false;            private var _scriptStarted:Boolean;            private var _powerTable:MovieClip;            private var _guildMc:MovieClip;            private var _lessonLiving:SmallLiving;            public function FightLibGameView() { super(); }
            override public function getType() : String { return null; }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            override protected function gameOver() : void { }
            override public function updateControlBarState(info:Living) : void { }
            private function __reAnswer(evt:MouseEvent) : void { }
            private function __viewTutorial(evt:MouseEvent) : void { }
            private function initScript() : void { }
            public function drawMasks() : void { }
            public function pauseGame() : void { }
            public function continueGame() : void { }
            public function moveToPlayer() : void { }
            public function splitSmallMapDrager() : void { }
            public function hideSmallMapSplit() : void { }
            public function restoreText() : void { }
            public function shineText() : void { }
            private function ScaleCompleteHandler() : void { }
            private function StartPlayHandler() : void { }
            private function GuildEndHandler() : void { }
            public function shineText2() : void { }
            private function onMoviePlay(e:Event) : void { }
            public function screanAddEvent() : void { }
            private function __downHandler(evt:MouseEvent) : void { }
            override protected function __playerChange(event:CrazyTankSocketEvent) : void { }
            public function clearMask() : void { }
            public function sendClientScriptStart() : void { }
            public function sendClientScriptEnd() : void { }
            private function __popupQuestionFrame(evt:CrazyTankSocketEvent) : void { }
            public function addRedPointInSmallMap() : void { }
            public function removeRedPointInSmallMap() : void { }
            public function leftJustifyWithPlayer() : void { }
            public function leftJustifyWithRedPoint() : void { }
            override public function addliving(event:CrazyTankSocketEvent) : void { }
            public function waitAttack() : void { }
            public function continueScript(evt:LivingEvent) : void { }
            public function closeShowTurn() : void { }
            public function openShowTurn() : void { }
            public function enableReanswerBtn() : void { }
            public function blockFly() : void { }
            public function blockSmallMap() : void { }
            public function blockExist() : void { }
            public function enableExist() : void { }
            public function activeSmallMap() : void { }
            public function skip() : void { }
            public function showPowerTable1() : void { }
            public function showPowerTable2() : void { }
            public function showPowerTable3() : void { }
            public function hidePowerTable() : void { }
            override public function dispose() : void { }
            override public function leaving(next:BaseStateView) : void { }
   }}