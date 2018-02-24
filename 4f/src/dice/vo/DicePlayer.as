package dice.vo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.VipLevelIcon;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import dice.controller.DiceController;
   import dice.event.DiceEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import vip.VipController;
   
   public class DicePlayer extends DicePlayerBase
   {
       
      
      private var _playerInfo:SelfInfo;
      
      private var _lblName:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _moveSpeedX:Number = 5;
      
      private var _moveSpeedY:Number = 4;
      
      private var _isShowName:Boolean = true;
      
      private var _propertyContainer:Sprite;
      
      private var _light:MovieClip;
      
      private var _isWalking:Boolean;
      
      public function DicePlayer(param1:Function = null){super(null,null,null);}
      
      public function get isWalking() : Boolean{return false;}
      
      public function set isWalking(param1:Boolean) : void{}
      
      private function preInitialize() : void{}
      
      private function addEvent() : void{}
      
      private function characterDirectionChange(param1:SceneCharacterEvent) : void{}
      
      private function __update(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      private function initialize() : void{}
      
      private function SynchronousPosition(param1:Point) : void{}
      
      public function PlayerWalkByPosition(param1:int, param2:int) : void{}
      
      public function GetCoordinatesByPosition(param1:int) : Point{return null;}
      
      public function set CurrentPosition(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
