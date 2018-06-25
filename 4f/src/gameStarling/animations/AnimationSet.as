package gameStarling.animations{   import gameStarling.view.map.MapView3D;      public class AnimationSet   {                   private var _map:MapView3D;            private var _running:Boolean;            private var _current:IAnimate;            private var _stageWidth:Number;            private var _stageHeight:Number;            private var _minX:Number;            private var _minY:Number;            public function AnimationSet(map:MapView3D, stageWidth:Number, stageHeight:Number) { super(); }
            public function get stageWidth() : Number { return 0; }
            public function get stageHeight() : Number { return 0; }
            public function get map() : MapView3D { return null; }
            public function get minX() : Number { return 0; }
            public function get minY() : Number { return 0; }
            public function get current() : IAnimate { return null; }
            public function addAnimation(anit:IAnimate) : void { }
            public function pause() : void { }
            public function play() : void { }
            public function dispose() : void { }
            public function clear() : void { }
            public function update() : Boolean { return false; }
   }}