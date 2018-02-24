package com.pickgliss.ui.controls
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.geom.OuterRectPos;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   [Event(name="response",type="com.pickgliss.events.FrameEvent")]
   public class Frame extends Component
   {
      
      public static const P_backgound:String = "backgound";
      
      public static const P_closeButton:String = "closeButton";
      
      public static const P_closeInnerRect:String = "closeInnerRect";
      
      public static const P_containerX:String = "containerX";
      
      public static const P_containerY:String = "containerY";
      
      public static const P_disposeChildren:String = "disposeChildren";
      
      public static const P_moveEnable:String = "moveEnable";
      
      public static const P_moveInnerRect:String = "moveInnerRect";
      
      public static const P_title:String = "title";
      
      public static const P_titleText:String = "titleText";
      
      public static const P_titleOuterRectPos:String = "titleOuterRectPos";
      
      public static const P_escEnable:String = "escEnable";
      
      public static const P_enterEnable:String = "enterEnable";
       
      
      protected var _backStyle:String;
      
      protected var _backgound:DisplayObject;
      
      protected var _closeButton:BaseButton;
      
      protected var _closeInnerRect:InnerRectangle;
      
      protected var _closeInnerRectString:String;
      
      protected var _closestyle:String;
      
      protected var _container:Sprite;
      
      protected var _containerPosString:String;
      
      protected var _containerX:Number;
      
      protected var _containerY:Number;
      
      protected var _moveEnable:Boolean;
      
      protected var _moveInnerRect:InnerRectangle;
      
      protected var _moveInnerRectString:String = "";
      
      protected var _moveRect:Sprite;
      
      protected var _title:TextField;
      
      protected var _titleStyle:String;
      
      protected var _titleText:String = "";
      
      protected var _disposeChildren:Boolean = true;
      
      protected var _titleOuterRectPosString:String;
      
      protected var _titleOuterRectPos:OuterRectPos;
      
      protected var _escEnable:Boolean;
      
      protected var _autoExit:Boolean = false;
      
      protected var _enterEnable:Boolean;
      
      public function Frame(){super();}
      
      protected function __onMouseClickSetFocus(param1:MouseEvent) : void{}
      
      public function addToContent(param1:DisplayObject) : void{}
      
      public function set backStyle(param1:String) : void{}
      
      public function set backgound(param1:DisplayObject) : void{}
      
      public function get closeButton() : BaseButton{return null;}
      
      public function set closeButton(param1:BaseButton) : void{}
      
      public function set closeInnerRectString(param1:String) : void{}
      
      public function set closestyle(param1:String) : void{}
      
      public function set containerX(param1:Number) : void{}
      
      public function set containerY(param1:Number) : void{}
      
      public function set titleOuterRectPosString(param1:String) : void{}
      
      override public function dispose() : void{}
      
      public function get disposeChildren() : Boolean{return false;}
      
      public function set disposeChildren(param1:Boolean) : void{}
      
      public function set moveEnable(param1:Boolean) : void{}
      
      public function set moveInnerRectString(param1:String) : void{}
      
      public function set title(param1:TextField) : void{}
      
      public function set titleStyle(param1:String) : void{}
      
      public function set titleText(param1:String) : void{}
      
      protected function __onAddToStage(param1:Event) : void{}
      
      protected function __onCloseClick(param1:MouseEvent) : void{}
      
      protected function __onKeyDown(param1:KeyboardEvent) : void{}
      
      public function set escEnable(param1:Boolean) : void{}
      
      public function get escEnable() : Boolean{return false;}
      
      public function set autoExit(param1:Boolean) : void{}
      
      public function get autoExit() : Boolean{return false;}
      
      protected function onFrameClose() : void{}
      
      public function set enterEnable(param1:Boolean) : void{}
      
      public function get enterEnable() : Boolean{return false;}
      
      protected function onResponse(param1:int) : void{}
      
      protected function __onFrameMoveStart(param1:MouseEvent) : void{}
      
      protected function __onFrameMoveStop(param1:MouseEvent) : void{}
      
      override protected function addChildren() : void{}
      
      override protected function init() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function updateClosePos() : void{}
      
      protected function updateContainerPos() : void{}
      
      protected function updateMoveRect() : void{}
      
      protected function updateTitlePos() : void{}
      
      protected function __onMoveWindow(param1:MouseEvent) : void{}
   }
}
