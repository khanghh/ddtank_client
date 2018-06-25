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
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         if(_childrenList.indexOf(child) > -1)
         {
            return child;
         }
         if(!_isReverAdd)
         {
            _childrenList.push(super.addChild(child));
         }
         else if(!_isReverAddList)
         {
            _childrenList.push(super.addChildAt(child,0));
         }
         else
         {
            _childrenList.splice(0,0,super.addChildAt(child,0));
         }
         child.addEventListener("propertiesChanged",__onResize);
         onPropertiesChanged("childRefresh");
         return child;
      }
      
      override public function dispose() : void
      {
         disposeAllChildren();
         _childrenList = null;
         super.dispose();
      }
      
      public function disposeAllChildren() : void
      {
         var i:int = 0;
         var child:* = null;
         for(i = 0; i < numChildren; )
         {
            child = getChildAt(i);
            child.removeEventListener("propertiesChanged",__onResize);
            i++;
         }
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function set isReverAdd(value:Boolean) : void
      {
         if(_isReverAdd == value)
         {
            return;
         }
         _isReverAdd = value;
         onPropertiesChanged("isReverAdd");
      }
      
      public function set isReverAddList(value:Boolean) : void
      {
         if(_isReverAddList == value)
         {
            return;
         }
         _isReverAddList = value;
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
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         child.removeEventListener("propertiesChanged",__onResize);
         _childrenList.splice(_childrenList.indexOf(child),1);
         super.removeChild(child);
         onPropertiesChanged("childRefresh");
         return child;
      }
      
      public function reverChildren() : void
      {
         var i:int = 0;
         var tempAllChildren:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         while(numChildren > 0)
         {
            tempAllChildren.push(removeChildAt(0));
         }
         for(i = 0; i < tempAllChildren.length; )
         {
            addChild(tempAllChildren[i]);
            i++;
         }
      }
      
      public function set autoSize(value:int) : void
      {
         if(_autoSize == value)
         {
            return;
         }
         _autoSize = value;
         onPropertiesChanged("autoSize");
      }
      
      public function get spacing() : Number
      {
         return _spacing;
      }
      
      public function set spacing(value:Number) : void
      {
         if(_spacing == value)
         {
            return;
         }
         _spacing = value;
         onPropertiesChanged("spacing");
      }
      
      public function set strictSize(value:Number) : void
      {
         if(_strictSize == value)
         {
            return;
         }
         _strictSize = value;
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
      
      private function __onResize(event:ComponentEvent) : void
      {
         if(event.changedProperties["height"] || event.changedProperties["width"])
         {
            onPropertiesChanged("childRefresh");
         }
      }
      
      protected function getItemWidth(child:DisplayObject) : Number
      {
         if(isStrictSize)
         {
            return _strictSize;
         }
         return child.width;
      }
      
      public function get realWidth() : Number
      {
         var i:int = 0;
         var w:* = 0;
         for(i = 0; i < _childrenList.length; )
         {
            w = Number(w + (getItemWidth(_childrenList[i]) + _spacing));
            i++;
         }
         return w - _spacing;
      }
   }
}
