package game.objects{   import com.pickgliss.loader.ModuleLoader;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import pet.data.PetInfo;   import road.game.resource.ActionMovie;      public class GamePetMovie extends Sprite implements Disposeable   {            public static const PlayEffect:String = "PlayEffect";                   private var _petInfo:PetInfo;            private var _player:GamePlayer;            private var _petMovie:ActionMovie;            public function GamePetMovie(info:PetInfo, player:GamePlayer) { super(); }
            private function initEvent() : void { }
            protected function __playPlayerEffect(event:Event) : void { }
            public function init() : void { }
            public function show(x:int = 0, y:int = 0) : void { }
            public function hide() : void { }
            public function get info() : PetInfo { return null; }
            public function set direction(val:int) : void { }
            public function doAction(type:String, callBack:Function = null, args:Array = null) : void { }
            public function dispose() : void { }
   }}