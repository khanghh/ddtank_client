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
      
      public function AnimationSet(param1:MapView, param2:Number, param3:Number){super();}
      
      public function get stageWidth() : Number{return 0;}
      
      public function get stageHeight() : Number{return 0;}
      
      public function get map() : MapView{return null;}
      
      public function get minX() : Number{return 0;}
      
      public function get minY() : Number{return 0;}
      
      public function get current() : IAnimate{return null;}
      
      public function addAnimation(param1:IAnimate) : void{}
      
      public function pause() : void{}
      
      public function play() : void{}
      
      public function dispose() : void{}
      
      public function clear() : void{}
      
      public function update() : Boolean{return false;}
   }
}
