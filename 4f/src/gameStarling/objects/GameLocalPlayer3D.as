package gameStarling.objects{   import bones.BoneMovieFactory;   import bones.display.BoneMovieStarling;   import com.pickgliss.utils.StarlingObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.LivingEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PetSkillManager;   import ddt.manager.SoundManager;   import ddt.view.character.ShowCharacter;   import ddt.view.characterStarling.GameCharacter3D;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.Timer;   import flash.utils.getTimer;   import gameCommon.GameControl;   import gameCommon.model.LocalPlayer;   import gameStarling.actions.FocusInLivingAction;   import gameStarling.actions.PlayerBeatAction;   import gameStarling.actions.SelfPlayerWalkAction;   import gameStarling.actions.SelfSkipAction;   import gameStarling.actions.newHand.NewHandFightHelpAction;   import gameStarling.animations.BaseSetCenterAnimation;   import gameStarling.animations.DragMapAnimation;   import org.aswing.KeyStroke;   import org.aswing.KeyboardManager;   import pet.data.PetSkillTemplateInfo;   import road7th.StarlingMain;   import room.RoomManager;   import starling.display.Image;   import starling.display.Sprite;      public class GameLocalPlayer3D extends GamePlayer3D   {            private static const MAX_MOVE_TIME:int = 10;                   private var _takeAim:Sprite;            private var _takeBg:Image;            private var _moveStripContainer:Sprite;            private var _moveStrip:Image;            private var _ballpos:Point;            protected var _shootTimer:Timer;            private var mouseAsset:BoneMovieStarling;            private var _turned:Boolean;            private var _transmissionEffoct:BoneMovieStarling;            private var _keyDownTime:int;            private var _currentReverse:int = 1;            private var _isChangeReverse:Boolean = true;            protected var _isShooting:Boolean = false;            protected var _shootCount:int = 0;            protected var _shootPoint:Point;            private var _shootOverCount:int = 0;            public function GameLocalPlayer3D(player:LocalPlayer, character:ShowCharacter, movie:GameCharacter3D = null, templeId:int = 0) { super(null,null,null,null); }
            public function get localPlayer() : LocalPlayer { return null; }
            public function get aim() : Sprite { return null; }
            override public function set pos(value:Point) : void { }
            override protected function initView() : void { }
            override protected function initListener() : void { }
            private function __setCenter(event:LivingEvent) : void { }
            override public function dispose() : void { }
            protected function __skip(event:LivingEvent) : void { }
            public function showTransmissionEffoct() : void { }
            private function __keyUp(event:KeyboardEvent) : void { }
            private function __turnLeft() : void { }
            private function __turnRight() : void { }
            protected function walk() : void { }
            override public function startMoving() : void { }
            override public function stopMoving() : void { }
            override protected function __attackingChanged(event:LivingEvent) : void { }
            override protected function attackingViewChanged() : void { }
            override public function die() : void { }
            override public function revive() : void { }
            private function __mouseClick(event:MouseEvent) : void { }
            public function hideTargetMouseTip() : void { }
            override protected function __usingItem(event:LivingEvent) : void { }
            protected function __sendShoot(event:LivingEvent) : void { }
            private function __shootTimer(event:Event) : void { }
            override protected function __shoot(event:LivingEvent) : void { }
            override protected function __beginNewTurn(event:LivingEvent) : void { }
            public function get shootOverCount() : int { return 0; }
            public function set shootOverCount(count:int) : void { }
            protected function __gunangleChanged(event:LivingEvent) : void { }
            protected function __beginShoot(event:LivingEvent) : void { }
            protected function __energyChanged(event:LivingEvent) : void { }
            override protected function __usePetSkill(event:LivingEvent) : void { }
   }}