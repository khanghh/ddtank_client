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
      
      public function Frame()
      {
         super();
         addEventListener("addedToStage",__onAddToStage);
         addEventListener("mouseDown",__onMouseClickSetFocus);
      }
      
      protected function __onMouseClickSetFocus(event:MouseEvent) : void
      {
         StageReferance.stage.focus = event.target as InteractiveObject;
      }
      
      public function addToContent(display:DisplayObject) : void
      {
         _container.addChild(display);
      }
      
      public function set backStyle(stylename:String) : void
      {
         if(_backStyle == stylename)
         {
            return;
         }
         _backStyle = stylename;
         backgound = ComponentFactory.Instance.creat(_backStyle);
      }
      
      public function set backgound(image:DisplayObject) : void
      {
         if(_backgound == image)
         {
            return;
         }
         ObjectUtils.disposeObject(_backgound);
         _backgound = image;
         if(_backgound is InteractiveObject)
         {
            InteractiveObject(_backgound).mouseEnabled = true;
         }
         onPropertiesChanged("backgound");
      }
      
      public function get closeButton() : BaseButton
      {
         return _closeButton;
      }
      
      public function set closeButton(button:BaseButton) : void
      {
         if(_closeButton == button)
         {
            return;
         }
         if(_closeButton)
         {
            _closeButton.removeEventListener("click",__onCloseClick);
            ObjectUtils.disposeObject(_closeButton);
         }
         _closeButton = button;
         onPropertiesChanged("closeButton");
      }
      
      public function set closeInnerRectString(value:String) : void
      {
         if(_closeInnerRectString == value)
         {
            return;
         }
         _closeInnerRectString = value;
         _closeInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_closeInnerRectString));
         onPropertiesChanged("closeInnerRect");
      }
      
      public function set closestyle(stylename:String) : void
      {
         if(_closestyle == stylename)
         {
            return;
         }
         _closestyle = stylename;
         closeButton = ComponentFactory.Instance.creat(_closestyle);
      }
      
      public function set containerX(value:Number) : void
      {
         if(_containerX == value)
         {
            return;
         }
         _containerX = value;
         onPropertiesChanged("containerX");
      }
      
      public function set containerY(value:Number) : void
      {
         if(_containerY == value)
         {
            return;
         }
         _containerY = value;
         onPropertiesChanged("containerY");
      }
      
      public function set titleOuterRectPosString(value:String) : void
      {
         if(_titleOuterRectPosString == value)
         {
            return;
         }
         _titleOuterRectPosString = value;
         _titleOuterRectPos = ClassUtils.CreatInstance("com.pickgliss.geom.OuterRectPos",ComponentFactory.parasArgs(_titleOuterRectPosString));
         onPropertiesChanged("titleOuterRectPos");
      }
      
      override public function dispose() : void
      {
         var focusDisplay:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(focusDisplay && contains(focusDisplay))
         {
            StageReferance.stage.focus = null;
         }
         StageReferance.stage.removeEventListener("mouseUp",__onFrameMoveStop);
         StageReferance.stage.removeEventListener("mouseMove",__onMoveWindow);
         StageReferance.stage.removeEventListener("keyDown",__onKeyDown);
         removeEventListener("mouseDown",__onMouseClickSetFocus);
         removeEventListener("addedToStage",__onAddToStage);
         if(_backgound)
         {
            ObjectUtils.disposeObject(_backgound);
         }
         _backgound = null;
         if(_closeButton)
         {
            _closeButton.removeEventListener("click",__onCloseClick);
            ObjectUtils.disposeObject(_closeButton);
         }
         _closeButton = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_disposeChildren)
         {
            ObjectUtils.disposeAllChildren(_container);
         }
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
         }
         _container = null;
         if(_moveRect)
         {
            _moveRect.removeEventListener("mouseDown",__onFrameMoveStart);
         }
         ObjectUtils.disposeObject(_moveRect);
         _moveRect = null;
         super.dispose();
      }
      
      public function get disposeChildren() : Boolean
      {
         return _disposeChildren;
      }
      
      public function set disposeChildren(value:Boolean) : void
      {
         if(_disposeChildren == value)
         {
            return;
         }
         _disposeChildren = value;
         onPropertiesChanged("disposeChildren");
      }
      
      public function set moveEnable(value:Boolean) : void
      {
         if(_moveEnable == value)
         {
            return;
         }
         _moveEnable = value;
         onPropertiesChanged("moveEnable");
      }
      
      public function set moveInnerRectString(value:String) : void
      {
         if(_moveInnerRectString == value)
         {
            return;
         }
         _moveInnerRectString = value;
         _moveInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_moveInnerRectString));
         onPropertiesChanged("moveInnerRect");
      }
      
      public function set title(text:TextField) : void
      {
         if(_title == text)
         {
            return;
         }
         _title = text;
         onPropertiesChanged("title");
      }
      
      public function set titleStyle(stylename:String) : void
      {
         if(_titleStyle == stylename)
         {
            return;
         }
         _titleStyle = stylename;
         title = ComponentFactory.Instance.creat(_titleStyle);
      }
      
      public function set titleText(value:String) : void
      {
         if(_titleText == value)
         {
            return;
         }
         _titleText = value;
         onPropertiesChanged("titleText");
      }
      
      protected function __onAddToStage(event:Event) : void
      {
         stage.focus = this;
      }
      
      protected function __onCloseClick(event:MouseEvent) : void
      {
         onResponse(0);
      }
      
      protected function __onKeyDown(event:KeyboardEvent) : void
      {
         var focusTarget:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(DisplayUtils.isTargetOrContain(focusTarget,this))
         {
            if(event.keyCode == 13 && enterEnable)
            {
               if(focusTarget is TextField && TextField(focusTarget).type == "input")
               {
                  return;
               }
               onResponse(2);
               event.stopImmediatePropagation();
            }
            else if(event.keyCode == 27 && escEnable)
            {
               onResponse(1);
               event.stopImmediatePropagation();
            }
         }
      }
      
      public function set escEnable(value:Boolean) : void
      {
         if(_escEnable == value)
         {
            return;
         }
         _escEnable = value;
         onPropertiesChanged("escEnable");
      }
      
      public function get escEnable() : Boolean
      {
         return _escEnable;
      }
      
      public function set autoExit(value:Boolean) : void
      {
         if(_autoExit == value)
         {
            return;
         }
         _autoExit = value;
      }
      
      public function get autoExit() : Boolean
      {
         return _autoExit;
      }
      
      protected function onFrameClose() : void
      {
      }
      
      public function set enterEnable(value:Boolean) : void
      {
         if(_enterEnable == value)
         {
            return;
         }
         _enterEnable = value;
         onPropertiesChanged("enterEnable");
      }
      
      public function get enterEnable() : Boolean
      {
         return _enterEnable;
      }
      
      protected function onResponse(type:int) : void
      {
         dispatchEvent(new FrameEvent(type));
         if(type == 0 || type == 1)
         {
            onFrameClose();
            if(_autoExit)
            {
               dispose();
            }
         }
      }
      
      protected function __onFrameMoveStart(event:MouseEvent) : void
      {
         StageReferance.stage.addEventListener("mouseMove",__onMoveWindow);
         StageReferance.stage.addEventListener("mouseUp",__onFrameMoveStop);
         startDrag();
      }
      
      protected function __onFrameMoveStop(event:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__onFrameMoveStop);
         StageReferance.stage.removeEventListener("mouseMove",__onMoveWindow);
         stopDrag();
      }
      
      override protected function addChildren() : void
      {
         if(_backgound)
         {
            addChild(_backgound);
         }
         if(_title)
         {
            addChild(_title);
         }
         addChild(_moveRect);
         addChild(_container);
         if(_closeButton)
         {
            addChild(_closeButton);
         }
      }
      
      override protected function init() : void
      {
         _container = new Sprite();
         _moveRect = new Sprite();
         super.init();
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if((_changedPropeties["height"] || _changedPropeties["width"]) && _backgound != null)
         {
            _backgound.width = _width;
            _backgound.height = _height;
            updateClosePos();
         }
         if(_changedPropeties["height"] || _changedPropeties["width"] || _changedPropeties["moveInnerRect"])
         {
            updateMoveRect();
         }
         if(_changedPropeties["closeButton"])
         {
            _closeButton.addEventListener("click",__onCloseClick);
         }
         if(_changedPropeties["closeButton"] || _changedPropeties["closeInnerRect"])
         {
            updateClosePos();
         }
         if(_changedPropeties["containerX"] || _changedPropeties["containerY"])
         {
            updateContainerPos();
         }
         if(_changedPropeties["titleOuterRectPos"] || _changedPropeties["titleText"] || _changedPropeties["height"] || _changedPropeties["width"])
         {
            if(_title != null)
            {
               _title.text = _titleText;
            }
            updateTitlePos();
         }
         if(_changedPropeties["moveEnable"])
         {
            if(_moveEnable)
            {
               _moveRect.addEventListener("mouseDown",__onFrameMoveStart);
            }
            else
            {
               _moveRect.removeEventListener("mouseDown",__onFrameMoveStart);
            }
         }
         if(_escEnable || _enterEnable)
         {
            StageReferance.stage.addEventListener("keyDown",__onKeyDown);
         }
         else
         {
            StageReferance.stage.removeEventListener("keyDown",__onKeyDown);
         }
      }
      
      protected function updateClosePos() : void
      {
         if(_closeButton && _closeInnerRect)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_closeButton,_closeInnerRect,_width,_height);
         }
      }
      
      protected function updateContainerPos() : void
      {
         _container.x = _containerX;
         _container.y = _containerY;
      }
      
      protected function updateMoveRect() : void
      {
         if(_moveInnerRect == null)
         {
            return;
         }
         var resultRect:Rectangle = _moveInnerRect.getInnerRect(_width,_height);
         _moveRect.graphics.clear();
         _moveRect.graphics.beginFill(0,0);
         _moveRect.graphics.drawRect(resultRect.x,resultRect.y,resultRect.width,resultRect.height);
         _moveRect.graphics.endFill();
      }
      
      protected function updateTitlePos() : void
      {
         if(_title == null)
         {
            return;
         }
         if(_titleOuterRectPos == null)
         {
            return;
         }
         var posRect:Point = _titleOuterRectPos.getPos(_title.width,_title.height,_width,_height);
         _title.x = posRect.x;
         _title.y = posRect.y;
      }
      
      protected function __onMoveWindow(event:MouseEvent) : void
      {
         if(DisplayUtils.isInTheStage(new Point(event.localX,event.localY),this))
         {
            event.updateAfterEvent();
         }
         else
         {
            __onFrameMoveStop(null);
         }
      }
   }
}
