package com.pickgliss.ui.controls.container
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   
   public class BoxContainer extends Component
   {
      
      public static const P_childRefresh:String = "childRefresh";
      
      public static const P_childResize:String = "childResize";
      
      public static const P_isReverAdd:String = "isReverAdd";
      
      public static const P_spacing:String = "spacing";
      
      public static const P_strictSize:String = "strictSize";
      
      public static const P_autoSize:String = "autoSize";
      
      public static const LEFT_OR_TOP:int = 0;
      
      public static const RIGHT_OR_BOTTOM:int = 1;
      
      public static const CENTER:int = 2;
      
      public static const NONE:int = 3;
       
      
      protected var _childrenList:Vector.<DisplayObject>;
      
      protected var _isReverAdd:Boolean;
      
      protected var _isReverAddList:Boolean;
      
      protected var _spacing:Number = 0;
      
      protected var _strictSize:Number = -1;
      
      protected var _autoSize:int = 0;
      
      public function BoxContainer(){super();}
      
      override public function addChild(param1:DisplayObject) : DisplayObject{return null;}
      
      override public function dispose() : void{}
      
      public function disposeAllChildren() : void{}
      
      public function set isReverAdd(param1:Boolean) : void{}
      
      public function set isReverAddList(param1:Boolean) : void{}
      
      public function refreshChildPos() : void{}
      
      public function removeAllChild() : void{}
      
      public function clearAllChild() : void{}
      
      override public function removeChild(param1:DisplayObject) : DisplayObject{return null;}
      
      public function reverChildren() : void{}
      
      public function set autoSize(param1:int) : void{}
      
      public function get spacing() : Number{return 0;}
      
      public function set spacing(param1:Number) : void{}
      
      public function set strictSize(param1:Number) : void{}
      
      public function arrange() : void{}
      
      protected function get isStrictSize() : Boolean{return false;}
      
      override protected function onProppertiesUpdate() : void{}
      
      private function __onResize(param1:ComponentEvent) : void{}
      
      protected function getItemWidth(param1:DisplayObject) : Number{return 0;}
      
      public function get realWidth() : Number{return 0;}
   }
}
