package gameStarling.objects{   import bones.game.ActionMovieBone;   import com.pickgliss.utils.StarlingObjectUtils;   import ddt.utils.PositionUtils;   import flash.geom.Point;   import pet.data.PetInfo;   import road7th.utils.BoneMovieWrapper;   import starling.display.Sprite;   import starling.events.Event;      public class GamePetMovie3D extends Sprite   {            public static const PlayEffect:String = "PlayEffect";                   private var _petInfo:PetInfo;            private var _player:GamePlayer3D;            private var _petMovie:ActionMovieBone;            public function GamePetMovie3D(info:PetInfo, player:GamePlayer3D) { super(); }
            private function onActionEffectEvent(movie:BoneMovieWrapper, args:Array = null) : void { }
            protected function __playPlayerEffect(event:Event) : void { }
            public function init() : void { }
            public function show(x:int = 0, y:int = 0) : void { }
            public function hide() : void { }
            public function get info() : PetInfo { return null; }
            public function set direction(val:int) : void { }
            public function doAction(type:String, callBack:Function = null, args:Array = null) : void { }
            override public function dispose() : void { }
   }}