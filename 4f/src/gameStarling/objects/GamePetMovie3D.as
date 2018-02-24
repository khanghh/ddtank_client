package gameStarling.objects
{
   import bones.game.ActionMovieBone;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.geom.Point;
   import pet.data.PetInfo;
   import road7th.utils.BoneMovieWrapper;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class GamePetMovie3D extends Sprite
   {
      
      public static const PlayEffect:String = "PlayEffect";
       
      
      private var _petInfo:PetInfo;
      
      private var _player:GamePlayer3D;
      
      private var _petMovie:ActionMovieBone;
      
      public function GamePetMovie3D(param1:PetInfo, param2:GamePlayer3D){super();}
      
      private function onActionEffectEvent(param1:BoneMovieWrapper, param2:Array = null) : void{}
      
      protected function __playPlayerEffect(param1:Event) : void{}
      
      public function init() : void{}
      
      public function show(param1:int = 0, param2:int = 0) : void{}
      
      public function hide() : void{}
      
      public function get info() : PetInfo{return null;}
      
      public function set direction(param1:int) : void{}
      
      public function doAction(param1:String, param2:Function = null, param3:Array = null) : void{}
      
      override public function dispose() : void{}
   }
}
