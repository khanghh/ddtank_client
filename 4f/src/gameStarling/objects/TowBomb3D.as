package gameStarling.objects{   import gameCommon.model.Bomb;   import gameCommon.model.Living;   import gameStarling.view.map.MapView3D;   import road7th.data.DictionaryData;   import starlingPhy.maps.Map3D;      public class TowBomb3D extends SimpleBomb3D   {                   private var _tempAction:Array;            private var _tempMap:Map3D;            public function TowBomb3D(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false) { super(null,null,null,null); }
            private function initData(info:Bomb) : void { }
            private function actionSort(a:BombAction3D, b:BombAction3D) : int { return 0; }
            override public function setMap(map:Map3D) : void { }
            override protected function isPillarCollide() : Boolean { return false; }
            override public function bomb() : void { }
            private function checkMonsterAction() : void { }
            override public function dispose() : void { }
   }}