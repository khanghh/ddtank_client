package gameCommon.view.prop{   import bagAndInfo.cell.DragEffect;   import com.greensock.TweenLite;   import com.greensock.TweenMax;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.PropInfo;   import ddt.interfaces.IAcceptDrag;   import ddt.interfaces.IDragable;   import ddt.manager.BitmapManager;   import ddt.manager.DragManager;   import ddt.manager.SharedManager;   import ddt.view.tips.ToolPropInfo;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import org.aswing.KeyboardManager;      public class PropCell extends Sprite implements Disposeable, ITipedDisplay, IDragable, IAcceptDrag   {                   protected var _x:int;            protected var _y:int;            protected var _enabled:Boolean = true;            protected var _info:PropInfo;            protected var _asset:DisplayObject;            protected var _isExist:Boolean;            protected var _back:DisplayObject;            protected var _fore:DisplayObject;            protected var _shortcutKey:String;            protected var _shortcutKeyShape:DisplayObject;            protected var _tipInfo:ToolPropInfo;            protected var _tweenMax:TweenLite;            protected var _localVisible:Boolean = true;            protected var _mode:int;            protected var _bitmapMgr:BitmapManager;            private var _allowDrag:Boolean;            protected var _grayFilters:Array;            private var _isUsed:Boolean;            public function PropCell(shortcutKey:String = null, mode:int = -1, allowDrag:Boolean = false) { super(); }
            public function get shortcutKey() : String { return null; }
            public function get isUsed() : Boolean { return false; }
            public function set isUsed(value:Boolean) : void { }
            public function dragStart() : void { }
            public function setGrayFilter() : void { }
            public function dragStop(effect:DragEffect) : void { }
            public function dragDrop(effect:DragEffect) : void { }
            public function getSource() : IDragable { return null; }
            public function asDisplayObject() : DisplayObject { return null; }
            public function get tipData() : Object { return null; }
            public function set tipData(value:Object) : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
            protected function configUI() : void { }
            protected function drawLayer() : void { }
            protected function addEvent() : void { }
            protected function __mouseOut(event:MouseEvent) : void { }
            protected function __mouseOver(event:MouseEvent) : void { }
            protected function removeEvent() : void { }
            public function get info() : PropInfo { return null; }
            public function setMode(mode:int) : void { }
            public function set info(val:PropInfo) : void { }
            public function get enabled() : Boolean { return false; }
            public function set enabled(val:Boolean) : void { }
            public function get isExist() : Boolean { return false; }
            public function set isExist(val:Boolean) : void { }
            public function setPossiton(x:int, y:int) : void { }
            public function dispose() : void { }
            public function useProp() : void { }
            public function get localVisible() : Boolean { return false; }
            public function setVisible(val:Boolean) : void { }
            public function set back(value:DisplayObject) : void { }
   }}