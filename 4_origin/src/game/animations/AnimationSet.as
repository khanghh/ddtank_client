package game.animations
{
   import game.view.map.MapView;
   
   public class AnimationSet
   {
       
      
      private var _map:MapView;
      
      private var _running:Boolean;
      
      private var _current:IAnimate;
      
      private var _stageWidth:Number;
      
      private var _stageHeight:Number;
      
      private var _minX:Number;
      
      private var _minY:Number;
      
      public function AnimationSet(param1:MapView, param2:Number, param3:Number)
      {
         super();
         _map = param1;
         _running = true;
         _current = null;
         _stageHeight = param3;
         _stageWidth = param2;
         _minX = -_map.width + param2;
         _minY = -_map.height + param3;
      }
      
      public function get stageWidth() : Number
      {
         return _stageWidth;
      }
      
      public function get stageHeight() : Number
      {
         return _stageHeight;
      }
      
      public function get map() : MapView
      {
         return _map;
      }
      
      public function get minX() : Number
      {
         return _minX;
      }
      
      public function get minY() : Number
      {
         return _minY;
      }
      
      public function get current() : IAnimate
      {
         return _current;
      }
      
      public function addAnimation(param1:IAnimate) : void
      {
         if(_current)
         {
            if(_current.level <= param1.level && _current.canReplace(param1))
            {
               _current.cancel();
               _current = param1;
               _current.prepare(this);
            }
         }
         else
         {
            _current = param1;
            _current.prepare(this);
         }
      }
      
      public function pause() : void
      {
         _running = false;
      }
      
      public function play() : void
      {
         _running = true;
      }
      
      public function dispose() : void
      {
         if(_current)
         {
            _current.cancel();
            _current = null;
         }
         _map = null;
      }
      
      public function clear() : void
      {
         if(_current)
         {
            _current.cancel();
         }
         _current = null;
      }
      
      public function update() : Boolean
      {
         if(_running && _current)
         {
            if(_current.canAct())
            {
               if(_current.update(_map))
               {
                  return true;
               }
               _current = null;
            }
            else
            {
               _current = null;
            }
         }
         return false;
      }
   }
}
