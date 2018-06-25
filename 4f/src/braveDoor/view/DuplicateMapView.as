package braveDoor.view{   import BraveDoor.BraveDoorManager;   import BraveDoor.data.BraveDoorDuplicateInfo;   import BraveDoor.data.DuplicateInfo;   import BraveDoor.event.BraveDoorEvent;   import braveDoor.BraveDoorControl;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.map.DungeonInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MapManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.filters.GlowFilter;   import road7th.data.DictionaryData;   import room.RoomManager;   import room.model.RoomInfo;      public class DuplicateMapView extends Sprite implements Disposeable   {                   private var _title:Bitmap = null;            private var _duplicateList:DictionaryData;            private var _duplicats:BraveDoorDuplicateInfo;            private var _mapSpri:Sprite;            private var _control:BraveDoorControl;            private var _curSelectDupID:int = -1;            private var _mapBg:Bitmap = null;            private var _baseBtn:duplicateIconButton;            public function DuplicateMapView() { super(); }
            public function initView($ctr:BraveDoorControl, $info:BraveDoorDuplicateInfo) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function selectedDulicateHandler(evt:BraveDoorEvent) : void { }
            public function set isEnableClick(value:Boolean) : void { }
            protected function createMap() : void { }
            protected function createDuplicates(info:BraveDoorDuplicateInfo) : void { }
            private function __btnOver(evt:MouseEvent) : void { }
            private function __btnOut(evt:MouseEvent) : void { }
            private function isCanFilter(dupId:int) : Boolean { return false; }
            private function updateDuplicateFilter(btn:duplicateIconButton, isAdd:Boolean) : void { }
            private function __duplicateClickHandler(evt:MouseEvent) : void { }
            private function levCheck(dupId:int) : Boolean { return false; }
            public function get curSelectDupID() : int { return 0; }
            public function set curSelectDupID(value:int) : void { }
            public function dispose() : void { }
   }}