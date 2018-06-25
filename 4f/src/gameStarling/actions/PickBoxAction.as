package gameStarling.actions{   import gameStarling.objects.GamePlayer3D;   import gameStarling.objects.SimpleBox3D;   import starlingPhy.object.PhysicalObj3D;      public class PickBoxAction   {                   public var executed:Boolean = false;            private var _time:int;            private var _boxid:int;            public function PickBoxAction(boxid:int, time:int) { super(); }
            public function get time() : int { return 0; }
            public function execute(player:GamePlayer3D) : void { }
   }}