package braveDoor.view{   import BraveDoor.event.BraveDoorEvent;   import braveDoor.BraveDoorControl;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.map.DungeonInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MapManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.events.MouseEvent;      public class DuplicateSelectView extends Frame implements Disposeable   {            public static var SELECT_DUPLICATE:String = "selectDuplicate";                   private var _duplicateMap:Bitmap;            private var _dropList:BraveDoorDropList;            private var _bg:Bitmap;            private var _selectDupBtn:BaseButton;            private var _info:DungeonInfo;            private var _control:BraveDoorControl;            public function DuplicateSelectView($ctr:BraveDoorControl) { super(); }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __selectDupHandler(evt:MouseEvent) : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            public function set duplicateID(id:int) : void { }
            private function updateMap($duplicateId:int) : void { }
            override public function dispose() : void { }
   }}