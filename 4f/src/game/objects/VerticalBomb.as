package game.objects{   import flash.geom.Point;   import gameCommon.model.Bomb;   import gameCommon.model.Living;      public class VerticalBomb extends SimpleBomb   {                   private var _isFall:Boolean;            public function VerticalBomb(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false) { super(null,null,null,null); }
            override protected function computeFallNextXY(dt:Number) : Point { return null; }
            override public function get motionAngle() : Number { return 0; }
            override public function get isFall() : Boolean { return false; }
            override protected function isPillarCollide() : Boolean { return false; }
   }}