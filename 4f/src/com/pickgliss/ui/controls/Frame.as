package com.pickgliss.ui.controls{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.geom.InnerRectangle;   import com.pickgliss.geom.OuterRectPos;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.InteractiveObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.text.TextField;      [Event(name="response",type="com.pickgliss.events.FrameEvent")]   public class Frame extends Component   {            public static const P_backgound:String = "backgound";            public static const P_closeButton:String = "closeButton";            public static const P_closeInnerRect:String = "closeInnerRect";            public static const P_containerX:String = "containerX";            public static const P_containerY:String = "containerY";            public static const P_disposeChildren:String = "disposeChildren";            public static const P_moveEnable:String = "moveEnable";            public static const P_moveInnerRect:String = "moveInnerRect";            public static const P_title:String = "title";            public static const P_titleText:String = "titleText";            public static const P_titleOuterRectPos:String = "titleOuterRectPos";            public static const P_escEnable:String = "escEnable";            public static const P_enterEnable:String = "enterEnable";                   protected var _backStyle:String;            protected var _backgound:DisplayObject;            protected var _closeButton:BaseButton;            protected var _closeInnerRect:InnerRectangle;            protected var _closeInnerRectString:String;            protected var _closestyle:String;            protected var _container:Sprite;            protected var _containerPosString:String;            protected var _containerX:Number;            protected var _containerY:Number;            protected var _moveEnable:Boolean;            protected var _moveInnerRect:InnerRectangle;            protected var _moveInnerRectString:String = "";            protected var _moveRect:Sprite;            protected var _title:TextField;            protected var _titleStyle:String;            protected var _titleText:String = "";            protected var _disposeChildren:Boolean = true;            protected var _titleOuterRectPosString:String;            protected var _titleOuterRectPos:OuterRectPos;            protected var _escEnable:Boolean;            protected var _autoExit:Boolean = false;            protected var _enterEnable:Boolean;            public function Frame() { super(); }
            protected function __onMouseClickSetFocus(event:MouseEvent) : void { }
            public function addToContent(display:DisplayObject) : void { }
            public function set backStyle(stylename:String) : void { }
            public function set backgound(image:DisplayObject) : void { }
            public function get closeButton() : BaseButton { return null; }
            public function set closeButton(button:BaseButton) : void { }
            public function set closeInnerRectString(value:String) : void { }
            public function set closestyle(stylename:String) : void { }
            public function set containerX(value:Number) : void { }
            public function set containerY(value:Number) : void { }
            public function set titleOuterRectPosString(value:String) : void { }
            override public function dispose() : void { }
            public function get disposeChildren() : Boolean { return false; }
            public function set disposeChildren(value:Boolean) : void { }
            public function set moveEnable(value:Boolean) : void { }
            public function set moveInnerRectString(value:String) : void { }
            public function set title(text:TextField) : void { }
            public function set titleStyle(stylename:String) : void { }
            public function set titleText(value:String) : void { }
            protected function __onAddToStage(event:Event) : void { }
            protected function __onCloseClick(event:MouseEvent) : void { }
            protected function __onKeyDown(event:KeyboardEvent) : void { }
            public function set escEnable(value:Boolean) : void { }
            public function get escEnable() : Boolean { return false; }
            public function set autoExit(value:Boolean) : void { }
            public function get autoExit() : Boolean { return false; }
            protected function onFrameClose() : void { }
            public function set enterEnable(value:Boolean) : void { }
            public function get enterEnable() : Boolean { return false; }
            protected function onResponse(type:int) : void { }
            protected function __onFrameMoveStart(event:MouseEvent) : void { }
            protected function __onFrameMoveStop(event:MouseEvent) : void { }
            override protected function addChildren() : void { }
            override protected function init() : void { }
            override protected function onProppertiesUpdate() : void { }
            protected function updateClosePos() : void { }
            protected function updateContainerPos() : void { }
            protected function updateMoveRect() : void { }
            protected function updateTitlePos() : void { }
            protected function __onMoveWindow(event:MouseEvent) : void { }
   }}