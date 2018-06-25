package com.pickgliss.ui.controls.list{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ComponentSetting;   import com.pickgliss.ui.controls.cell.IDropListCell;   import com.pickgliss.ui.controls.container.BoxContainer;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.InteractiveObject;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;      public class DropList extends Component implements Disposeable   {            public static const SELECTED:String = "selected";            public static const P_backgound:String = "backgound";            public static const P_container:String = "container";                   private var _backStyle:String;            private var _backGround:DisplayObject;            private var _cellStyle:String;            private var _containerStyle:String;            private var _container:BoxContainer;            private var _targetDisplay:IDropListTarget;            private var _showLength:int;            private var _dataList:Array;            private var _items:Vector.<IDropListCell>;            private var _currentSelectedIndex:int;            private var _preItemIdx:int;            private var _cellHeight:int;            private var _cellWidth:int;            private var _isListening:Boolean;            private var _canUseEnter:Boolean = true;            public function DropList() { super(); }
            override protected function init() : void { }
            public function set container(value:BoxContainer) : void { }
            public function set containerStyle(value:String) : void { }
            public function set cellStyle(value:String) : void { }
            public function set dataList(value:Array) : void { }
            private function updateBg() : void { }
            private function getHightLightItemIdx() : int { return 0; }
            private function unSelectedAllItems() : int { return 0; }
            private function updateItemValue(isUpWard:Boolean = false) : void { }
            private function setHightLightItem(isUpWard:Boolean = false) : void { }
            override protected function addChildren() : void { }
            public function set targetDisplay(target:IDropListTarget) : void { }
            private function __onRemoveFromStage(event:Event) : void { }
            public function set showLength(value:int) : void { }
            private function __onCellMouseClick(event:MouseEvent) : void { }
            private function __onCellMouseOver(event:MouseEvent) : void { }
            override protected function onProppertiesUpdate() : void { }
            private function __onKeyDown(event:KeyboardEvent) : void { }
            public function set canUseEnter(boo:Boolean) : void { }
            public function get canUseEnter() : Boolean { return false; }
            public function set currentSelectedIndex(idx:int) : void { }
            private function setTargetValue() : void { }
            private function __setSelection(event:Event) : void { }
            public function set backStyle(stylename:String) : void { }
            public function set backgound(image:DisplayObject) : void { }
            override public function dispose() : void { }
   }}