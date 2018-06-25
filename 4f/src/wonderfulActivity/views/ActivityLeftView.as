package wonderfulActivity.views{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import wonderfulActivity.WonderfulActivityManager;   import wonderfulActivity.event.WonderfulActivityEvent;      public class ActivityLeftView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _vbox:VBox;            private var _unitList:Vector.<ActivityLeftUnitView>;            private var tempArray:Array;            private var _rightFun:Function;            private var selectedUnitIndex:int;            private var _isNewServerExist:Boolean = false;            public function ActivityLeftView() { super(); }
            public function setRightView(fun:Function) : void { }
            private function initView() : void { }
            public function addUnitByType(arr:Array, type:int) : void { }
            private function setBgHeight(leftUnit:ActivityLeftUnitView) : void { }
            public function checkNewServerExist() : void { }
            public function extendUnitView() : void { }
            private function getLeftUnitView(type:int) : ActivityLeftUnitView { return null; }
            private function refreshView(event:WonderfulActivityEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
            public function get isNewServerExist() : Boolean { return false; }
            public function set isNewServerExist(value:Boolean) : void { }
   }}