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
      
      public function WeddingRoomSwitchMovie(param1:Boolean, param2:Number = 0.02)
      {
         super();
         this._autoClear = param1;
         this._speed = param2;
         init();
      }
      
      private function init() : void
      {
         _sprite = new Sprite();
         _sprite.graphics.beginFill(0);
         _sprite.graphics.drawRect(-1000,-1000,3000,2600);
         _sprite.graphics.endFill();
         _sprite.alpha = 0;
         addChild(_sprite);
         _currentStatus = "mask show";
      }
      
      public function playMovie() : void
      {
         addEventListener("enterFrame",__enterFrame);
      }
      
      private function __enterFrame(param1:Event) : void
      {
         if(_currentStatus == "mask show")
         {
            _sprite.alpha = _sprite.alpha + _speed;
            if(_sprite.alpha >= 1)
            {
               _currentStatus = "mask hide";
               dispatchEvent(new Event("switch complete"));
            }
         }
         else if(_currentStatus == "mask hide")
         {
            _sprite.alpha = _sprite.alpha - _speed;
            if(_sprite.alpha <= 0)
            {
               _currentStatus = "mask show";
               removeEventListener("enterFrame",__enterFrame);
               if(_autoClear)
               {
                  dispose();
               }
            }
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("enterFrame",__enterFrame);
         if(_sprite && _sprite.parent)
         {
            _sprite.parent.removeChild(_sprite);
         }
         _sprite = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
