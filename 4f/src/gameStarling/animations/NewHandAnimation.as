package gameStarling.animations{   import flash.geom.Point;   import gameStarling.view.map.MapView3D;      public class NewHandAnimation extends BaseSetCenterAnimation   {                   public function NewHandAnimation(cx:Number, cy:Number, life:int = 0, directed:Boolean = false, level:int = 0, speed:int = 4, data:Object = null) { super(null,null,null,null,null); }
            override public function canAct() : Boolean { return false; }
            override public function prepare(aniset:AnimationSet) : void { }
            override public function update(movie:MapView3D) : Boolean { return false; }
   }}