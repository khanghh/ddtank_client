package church.view.weddingRoom
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class WeddingRoomSwitchMovie extends Sprite
   {
      
      public static const SWITCH_COMPLETE:String = "switch complete";
       
      
      private const SHOW:String = "mask show";
      
      private const HIDE:String = "mask hide";
      
      private var _currentStatus:String;
      
      private var _sprite:Sprite;
      
      private var _autoClear:Boolean;
      
      private var _speed:Number;
      
      public function WeddingRoomSwitchMovie(param1:Boolean, param2:Number = 0.02){super();}
      
      private function init() : void{}
      
      public function playMovie() : void{}
      
      private function __enterFrame(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
