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
      
      public function BoxContainer()
      {
         _childrenList = new Vector.<DisplayObject>();
         super();
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         if(_childrenList.indexOf(param1) > -1)
         {
            return param1;
         }
         if(!_isReverAdd)
         {
            _childrenList.push(super.addChild(param1));
         }
         else if(!_isReverAddList)
         {
            _childrenList.push(super.addChildAt(param1,0));
         }
         else
         {
            _childrenList.splice(0,0,super.addChildAt(param1,0));
         }
         param1.addEventListener("propertiesChanged",__onResize);
         onPropertiesChanged("childRefresh");
         return param1;
      }
      
      override public function dispose() : void
      {
         disposeAllChildren();
         _childrenList = null;
         super.dispose();
      }
      
      public function disposeAllChildren() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < numChildren)
         {
            _loc1_ = getChildAt(_loc2_);
            _loc1_.removeEventListener("propertiesChanged",__onResize);
            _loc2_++;
         }
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function set isReverAdd(param1:Boolean) : void
      {
         if(_isReverAdd == param1)
         {
            return;
         }
         _isReverAdd = param1;
         onPropertiesChanged("isReverAdd");
      }
      
      public function set isReverAddList(param1:Boolean) : void
      {
         if(_isReverAddList == param1)
         {
            return;
         }
         _isReverAddList = param1;
      }
      
      public function refreshChildPos() : void
      {
         onPropertiesChanged("childResize");
      }
      
      public function removeAllChild() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         _childrenList.length = 0;
      }
      
      public function clearAllChild() : void
      {
         while(numChildren > 0)
         {
            ObjectUtils.disposeObject(removeChild(getChildAt(0)));
         }
         _childrenList.length = 0;
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         param1.removeEventListener("propertiesChanged",__onResize);
         _childrenList.splice(_childrenList.indexOf(param1),1);
         super.removeChild(param1);
         onPropertiesChanged("childRefresh");
         return param1;
      }
      
      public function reverChildren() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         while(numChildren > 0)
         {
            _loc1_.push(removeChildAt(0));
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            addChild(_loc1_[_loc2_]);
            _loc2_++;
         }
      }
      
      public function set autoSize(param1:int) : void
      {
         if(_autoSize == param1)
         {
            return;
         }
         _autoSize = param1;
         onPropertiesChanged("autoSize");
      }
      
      public function get spacing() : Number
      {
         return _spacing;
      }
      
      public function set spacing(param1:Number) : void
      {
         if(_spacing == param1)
         {
            return;
         }
         _spacing = param1;
         onPropertiesChanged("spacing");
      }
      
      public function set strictSize(param1:Number) : void
      {
         if(_strictSize == param1)
         {
            return;
         }
         _strictSize = param1;
         onPropertiesChanged("strictSize");
      }
      
      public function arrange() : void
      {
      }
      
      protected function get isStrictSize() : Boolean
      {
         return _strictSize > 0;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         arrange();
      }
      
      private function __onResize(param1:ComponentEvent) : void
      {
         if(param1.changedProperties["height"] || param1.changedProperties["width"])
         {
            onPropertiesChanged("childRefresh");
         }
      }
      
      protected function getItemWidth(param1:DisplayObject) : Number
      {
         if(isStrictSize)
         {
            return _strictSize;
         }
         return param1.width;
      }
      
      public function get realWidth() : Number
      {
         var _loc2_:int = 0;
         var _loc1_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < _childrenList.length)
         {
            _loc1_ = Number(_loc1_ + (getItemWidth(_childrenList[_loc2_]) + _spacing));
            _loc2_++;
         }
         return _loc1_ - _spacing;
      }
   }
}
