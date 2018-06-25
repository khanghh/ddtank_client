package ddt.view.character{   import ddt.data.EquipType;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.PlayerInfo;   import ddt.manager.ItemManager;   import flash.display.BitmapData;   import flash.display.MovieClip;      public class RoomCharaterLoader extends BaseCharacterLoader   {                   private var _suit:BitmapData;            private var _faceUpBmd:BitmapData;            private var _faceBmd:BitmapData;            private var _hairBmd:BitmapData;            private var _armBmd:BitmapData;            public var showWeapon:Boolean;            public function RoomCharaterLoader(info:PlayerInfo) { super(null); }
            override protected function initLayers() : void { }
            override protected function getIndexByTemplateId(id:String) : int { return 0; }
            private function loadPart(index:int) : void { }
            private function laodArm() : void { }
            override protected function drawCharacter() : void { }
            override public function getContent() : Array { return null; }
   }}