package explorerManual.data{   import explorerManual.ExplorerManualManager;      public class ManualPageDebrisInfo   {                   private var _debris:Vector.<DebrisInfo>;            public function ManualPageDebrisInfo() { super(); }
            public function get debris() : Vector.<DebrisInfo> { return null; }
            public function set debris(value:Vector.<DebrisInfo>) : void { }
            public function getHaveDebrisByPageID(pageID:int) : Array { return null; }
            private function debrisSort(x:DebrisInfo, y:DebrisInfo) : Number { return 0; }
   }}