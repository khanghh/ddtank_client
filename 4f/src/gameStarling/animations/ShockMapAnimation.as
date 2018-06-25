package gameStarling.animations{   import gameStarling.objects.SimpleBomb3D;   import gameStarling.view.map.MapView3D;   import starlingPhy.object.PhysicalObj3D;      public class ShockMapAnimation implements IAnimate   {                   private var _bomb:PhysicalObj3D;            private var _finished:Boolean;            private var _age:Number;            private var _life:Number;            private var _radius:Number;            private var _x:Number;            private var _y:Number;            private var _scale:int;            public function ShockMapAnimation(bomb:PhysicalObj3D, radius:Number = 7, life:Number = 0) { super(); }
            public function get level() : int { return 0; }
            public function get scale() : int { return 0; }
            public function canAct() : Boolean { return false; }
            public function canReplace(anit:IAnimate) : Boolean { return false; }
            public function prepare(aniset:AnimationSet) : void { }
            public function cancel() : void { }
            public function update(movie:MapView3D) : Boolean { return false; }
            public function get finish() : Boolean { return false; }
   }}