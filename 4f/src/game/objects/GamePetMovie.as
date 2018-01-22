package game.objects
{
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import pet.data.PetInfo;
   import road.game.resource.ActionMovie;
   
   public class GamePetMovie extends Sprite implements Disposeable
   {
      
      public static const PlayEffect:String = "PlayEffect";
       
      
      private var _petInfo:PetInfo;
      
      private var _player:GamePlayer;
      
      private var _petMovie:ActionMovie;
      
      public function GamePetMovie(param1:PetInfo, param2:GamePlayer){super();}
      
      private function initEvent() : void{}
      
      protected function __playPlayerEffect(param1:Event) : void{}
      
      public function init() : void{}
      
      public function show(param1:int = 0, param2:int = 0) : void{}
      
      public function hide() : void{}
      
      public function get info() : PetInfo{return null;}
      
      public function set direction(param1:int) : void{}
      
      public function doAction(param1:String, param2:Function = null, param3:Array = null) : void{}
      
      public function dispose() : void{}
   }
}
