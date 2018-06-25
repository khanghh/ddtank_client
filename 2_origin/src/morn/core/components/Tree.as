package morn.core.components
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import morn.core.handlers.Handler;
   import morn.editor.core.IRender;
   
   [Event(name="change",type="flash.events.Event")]
   public class Tree extends Box implements IRender
   {
       
      
      protected var _list:List;
      
      protected var _source:Array;
      
      protected var _xml:XML;
      
      protected var _renderHandler:Handler;
      
      protected var _spaceLeft:Number = 10;
      
      protected var _spaceBottom:Number = 0;
      
      protected var _keepOpenStatus:Boolean = true;
      
      public function Tree()
      {
         super();
         height = 200;
         width = 200;
      }
      
      override protected function createChildren() : void
      {
         _list = new List();
         addChild(new List());
         _list.renderHandler = new Handler(renderItem);
         _list.addEventListener("change",onListChange);
      }
      
      private function onListChange(e:Event) : void
      {
         sendEvent("change");
      }
      
      public function get keepOpenStatus() : Boolean
      {
         return _keepOpenStatus;
      }
      
      public function set keepOpenStatus(value:Boolean) : void
      {
         _keepOpenStatus = value;
      }
      
      public function get array() : Array
      {
         return _list.array;
      }
      
      public function set array(value:Array) : void
      {
         if(_keepOpenStatus && _list.array && value)
         {
            parseOpenStatus(_list.array,value);
         }
         _source = value;
         _list.array = getArray();
      }
      
      public function get source() : Array
      {
         return _source;
      }
      
      public function get list() : List
      {
         return _list;
      }
      
      public function get itemRender() : *
      {
         return _list.itemRender;
      }
      
      public function set itemRender(value:*) : void
      {
         _list.itemRender = value;
      }
      
      public function get scrollBarSkin() : String
      {
         return _list.vScrollBarSkin;
      }
      
      public function set scrollBarSkin(value:String) : void
      {
         _list.vScrollBarSkin = value;
      }
      
      public function get mouseHandler() : Handler
      {
         return _list.mouseHandler;
      }
      
      public function set mouseHandler(value:Handler) : void
      {
         _list.mouseHandler = value;
      }
      
      public function get renderHandler() : Handler
      {
         return _renderHandler;
      }
      
      public function set renderHandler(value:Handler) : void
      {
         _renderHandler = value;
      }
      
      public function get spaceLeft() : Number
      {
         return _spaceLeft;
      }
      
      public function set spaceLeft(value:Number) : void
      {
         _spaceLeft = value;
      }
      
      public function get spaceBottom() : Number
      {
         return _list.spaceY;
      }
      
      public function set spaceBottom(value:Number) : void
      {
         _list.spaceY = value;
      }
      
      public function get selectedIndex() : int
      {
         return _list.selectedIndex;
      }
      
      public function set selectedIndex(value:int) : void
      {
         _list.selectedIndex = value;
      }
      
      public function get selectedItem() : Object
      {
         return _list.selectedItem;
      }
      
      public function set selectedItem(value:Object) : void
      {
         _list.selectedItem = value;
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
         _list.width = value;
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         _list.height = value;
      }
      
      protected function getArray() : Array
      {
         var arr:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _source;
         for each(var item in _source)
         {
            if(getParentOpenStatus(item))
            {
               item.x = _spaceLeft * getDepth(item);
               arr.push(item);
            }
         }
         return arr;
      }
      
      protected function getDepth(item:Object, num:int = 0) : int
      {
         if(item.nodeParent == null)
         {
            return num;
         }
         return getDepth(item.nodeParent,num + 1);
      }
      
      protected function getParentOpenStatus(item:Object) : Boolean
      {
         var parent:Object = item.nodeParent;
         if(parent == null)
         {
            return true;
         }
         if(parent.isOpen)
         {
            if(parent.nodeParent != null)
            {
               return getParentOpenStatus(parent);
            }
            return true;
         }
         return false;
      }
      
      private function renderItem(cell:Box, index:int) : void
      {
         var arrow:* = null;
         var folder:* = null;
         var item:Object = cell.dataSource;
         if(item)
         {
            cell.left = item.x;
            arrow = cell.getChildByName("arrow") as Clip;
            if(arrow)
            {
               if(item.hasChild)
               {
                  arrow.visible = true;
                  arrow.frame = !!item.isOpen?1:0;
                  arrow.tag = index;
                  arrow.addEventListener("click",onArrowClick);
               }
               else
               {
                  arrow.visible = false;
               }
            }
            folder = cell.getChildByName("folder") as Clip;
            if(folder)
            {
               if(folder.clipY == 2)
               {
                  folder.frame = !!item.isDirectory?0:1;
               }
               else
               {
                  folder.frame = !!item.isDirectory?!!item.isOpen?1:0:2;
               }
            }
            if(_renderHandler != null)
            {
               _renderHandler.executeWith([cell,index]);
            }
         }
      }
      
      private function onArrowClick(e:MouseEvent) : void
      {
         var arrow:Clip = e.currentTarget as Clip;
         var index:int = arrow.tag;
         _list.array[index].isOpen = !_list.array[index].isOpen;
         _list.array = getArray();
      }
      
      override public function set dataSource(value:Object) : void
      {
         _dataSource = value;
         if(value is XML)
         {
            xml = value as XML;
         }
         else
         {
            .super.dataSource = value;
         }
      }
      
      public function get xml() : XML
      {
         return _xml;
      }
      
      public function set xml(value:XML) : void
      {
         _xml = value;
         var arr:Array = [];
         parseXml(xml,arr,null,true);
         array = arr;
      }
      
      protected function parseXml(xml:XML, source:Array, nodeParent:Object, isRoot:Boolean) : void
      {
         var obj:* = null;
         var list2:* = null;
         var prop:* = null;
         var value:* = null;
         var i:int = 0;
         var node:* = null;
         var list:XMLList = xml.children();
         var childCount:int = list.length();
         if(!isRoot)
         {
            obj = {};
            list2 = xml.attributes();
            var _loc15_:int = 0;
            var _loc14_:* = list2;
            for each(var attrs in list2)
            {
               prop = attrs.name().toString();
               value = attrs;
               obj[prop] = value == "true"?true:value == "false"?false:value;
            }
            obj.nodeParent = nodeParent;
            if(childCount > 0)
            {
               obj.isDirectory = true;
            }
            obj.hasChild = childCount > 0;
            source.push(obj);
         }
         for(i = 0; i < childCount; )
         {
            node = list[i];
            parseXml(node,source,obj,false);
            i++;
         }
      }
      
      protected function parseOpenStatus(oldSource:Array, newSource:Array) : void
      {
         var i:int = 0;
         var n:int = 0;
         var newItem:* = null;
         var j:int = 0;
         var m:int = 0;
         var oldItem:* = null;
         for(i = 0,n = newSource.length; i < n; )
         {
            newItem = newSource[i];
            if(newItem.isDirectory)
            {
               for(j = 0,m = oldSource.length; j < m; )
               {
                  oldItem = oldSource[j];
                  if(oldItem.isDirectory && isSameParent(oldItem,newItem) && newItem.label == oldItem.label)
                  {
                     newItem.isOpen = oldItem.isOpen;
                     break;
                  }
                  j++;
               }
            }
            i++;
         }
      }
      
      protected function isSameParent(item1:Object, item2:Object) : Boolean
      {
         if(item1.nodeParent == null && item2.nodeParent == null)
         {
            return true;
         }
         if(item1.nodeParent == null || item2.nodeParent == null)
         {
            return false;
         }
         if(item1.nodeParent.label == item2.nodeParent.label)
         {
            return isSameParent(item1.nodeParent,item2.nodeParent);
         }
         return false;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _list && _list.dispose();
         _list = null;
         _source = null;
         _xml = null;
         _renderHandler = null;
      }
   }
}
