package gameStarling.animations{   public class DragMapAnimation extends BaseSetCenterAnimation   {                   public function DragMapAnimation(cx:Number, cy:Number, directed:Boolean = false, life:int = 100) { super(null,null,null,null,null); }
            override public function canAct() : Boolean { return false; }
   }}