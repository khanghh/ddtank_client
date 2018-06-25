package game.objects{   import ddt.manager.SoundManager;   import flash.utils.setTimeout;   import game.view.map.MapView;   import gameCommon.model.Bomb;   import gameCommon.model.Living;      public class SpiderBomb1 extends SimpleBomb   {                   private var tempChilds:Array;            private var tempMap:MapView;            public function SpiderBomb1(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false) { super(null,null,null,null); }
            override public function bomb() : void { }
            private function forCreate() : void { }
            private function createBomb(childBomb:Bomb) : void { }
            override protected function isPillarCollide() : Boolean { return false; }
   }}