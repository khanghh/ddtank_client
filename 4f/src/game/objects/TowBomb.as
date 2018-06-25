package game.objects{   import flash.geom.Point;   import game.view.map.MapView;   import gameCommon.model.Bomb;   import gameCommon.model.GameInfo;   import gameCommon.model.Living;   import phy.maps.Map;   import phy.object.PhysicalObj;      public class TowBomb extends SimpleBomb   {                   private var _tempAction:Array;            private var _tempMap:Map;            public function TowBomb(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false) { super(null,null,null,null); }
            private function initData(info:Bomb) : void { }
            private function actionSort(a:BombAction, b:BombAction) : int { return 0; }
            override public function setMap(map:Map) : void { }
            override protected function isPillarCollide() : Boolean { return false; }
            override public function bomb() : void { }
            private function exeTempAction() : void { }
            override public function dispose() : void { }
   }}