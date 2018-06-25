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
      
      public function AnimationSet(map:MapView, stageWidth:Number, stageHeight:Number)
      {
         super();
         _map = map;
         _running = true;
         _current = null;
         _stageHeight = stageHeight;
         _stageWidth = stageWidth;
         _minX = -_map.width + stageWidth;
         _minY = -_map.height + stageHeight;
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
      
      public function addAnimation(anit:IAnimate) : void
      {
         if(_current)
         {
            if(_current.level <= anit.level && _current.canReplace(anit))
            {
               _current.cancel();
               _current = anit;
               _current.prepare(this);
            }
         }
         else
         {
            _current = anit;
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
