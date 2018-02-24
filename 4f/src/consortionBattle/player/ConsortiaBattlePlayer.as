package consortionBattle.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleController;
   import consortionBattle.ConsortiaBattleManager;
   import consortionBattle.view.ConsBatResurrectView;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import flash.utils.setTimeout;
   import hall.player.HallPlayerBase;
   
   public class ConsortiaBattlePlayer extends HallPlayerBase implements Disposeable
   {
      
      public static const CLICK:String = "consBatPlayerClick";
       
      
      private var _playerData:ConsortiaBattlePlayerInfo;
      
      private var _swordIcon:MovieClip;
      
      private var _consortiaNameTxt:FilterFrameText;
      
      private var _tombstone:MovieClip;
      
      private var _fighting:MovieClip;
      
      private var _resurrectView:ConsBatResurrectView;
      
      private var _resurrectCartoon:MovieClip;
      
      private var _winningStreakMc:MovieClip;
      
      private var _character:Sprite;
      
      private var _currentWalkStartPoint:Point;
      
      private var _isJustWin:Boolean;
      
      private var _walkSpeed:Number;
      
      public function ConsortiaBattlePlayer(param1:ConsortiaBattlePlayerInfo, param2:Function = null){super(null,null);}
      
      private function setPlayerWalkSpeed() : void{}
      
      protected function initView() : void{}
      
      public function refreshStatus() : void{}
      
      private function canClickedFight() : void{}
      
      private function createRrsurrectView(param1:int) : void{}
      
      private function resurrectHandler() : void{}
      
      private function cartoonCompleteHandler(param1:Event) : void{}
      
      protected function initEvent() : void{}
      
      override protected function __onMouseClick(param1:MouseEvent) : void{}
      
      override protected function __onMouseOver(param1:MouseEvent) : void{}
      
      private function showSwordMouse() : void{}
      
      private function mouseMoveHandler(param1:MouseEvent) : void{}
      
      private function hideSwordMouse() : void{}
      
      override protected function __onMouseOut(param1:MouseEvent) : void{}
      
      public function get isEnemy() : Boolean{return false;}
      
      private function get isCanBeFight() : Boolean{return false;}
      
      public function set setSceneCharacterDirectionDefault(param1:SceneCharacterDirection) : void{}
      
      public function get isCanWalk() : Boolean{return false;}
      
      public function updatePlayer() : void{}
      
      public function refreshCharacterState() : void{}
      
      private function characterMirror() : void{}
      
      private function playerWalkPath() : void{}
      
      private function fixPlayerPath() : void{}
      
      override public function playerWalk(param1:Array) : void{}
      
      private function setPlayerDirection() : SceneCharacterDirection{return null;}
      
      public function get playerData() : ConsortiaBattlePlayerInfo{return null;}
      
      public function get isInTomb() : Boolean{return false;}
      
      public function get isInFighting() : Boolean{return false;}
      
      private function characterDirectionChange(param1:Boolean) : void{}
      
      protected function removeEvent() : void{}
      
      public function get currentWalkStartPoint() : Point{return null;}
      
      override public function dispose() : void{}
   }
}
