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
         this.width = this.height = 200;
      }
      
      override protected function createChildren() : void
      {
         addChild(this._list = new List());
         this._list.renderHandler = new Handler(this.renderItem);
         this._list.addEventListener(Event.CHANGE,this.onListChange);
      }
      
      private function onListChange(param1:Event) : void
      {
         sendEvent(Event.CHANGE);
      }
      
      public function get keepOpenStatus() : Boolean
      {
         return this._keepOpenStatus;
      }
      
      public function set keepOpenStatus(param1:Boolean) : void
      {
         this._keepOpenStatus = param1;
      }
      
      public function get array() : Array
      {
         return this._list.array;
      }
      
      public function set array(param1:Array) : void
      {
         if(this._keepOpenStatus && this._list.array && param1)
         {
            this.parseOpenStatus(this._list.array,param1);
         }
         this._source = param1;
         this._list.array = this.getArray();
      }
      
      public function get source() : Array
      {
         return this._source;
      }
      
      public function get list() : List
      {
         return this._list;
      }
      
      public function get itemRender() : *
      {
         return this._list.itemRender;
      }
      
      public function set itemRender(param1:*) : void
      {
         this._list.itemRender = param1;
      }
      
      public function get scrollBarSkin() : String
      {
         return this._list.vScrollBarSkin;
      }
      
      public function set scrollBarSkin(param1:String) : void
      {
         this._list.vScrollBarSkin = param1;
      }
      
      public function get mouseHandler() : Handler
      {
         return this._list.mouseHandler;
      }
      
      public function set mouseHandler(param1:Handler) : void
      {
         this._list.mouseHandler = param1;
      }
      
      public function get renderHandler() : Handler
      {
         return this._renderHandler;
      }
      
      public function set renderHandler(param1:Handler) : void
      {
         this._renderHandler = param1;
      }
      
      public function get spaceLeft() : Number
      {
         return this._spaceLeft;
      }
      
      public function set spaceLeft(param1:Number) : void
      {
         this._spaceLeft = param1;
      }
      
      public function get spaceBottom() : Number
      {
         return this._list.spaceY;
      }
      
      public function set spaceBottom(param1:Number) : void
      {
         this._list.spaceY = param1;
      }
      
      public function get selectedIndex() : int
      {
         return this._list.selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         this._list.selectedIndex = param1;
      }
      
      public function get selectedItem() : Object
      {
         return this._list.selectedItem;
      }
      
      public function set selectedItem(param1:Object) : void
      {
         this._list.selectedItem = param1;
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this._list.width = param1;
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         this._list.height = param1;
      }
      
      protected function getArray() : Array
      {
         var _loc2_:Object = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._source)
         {
            if(this.getParentOpenStatus(_loc2_))
            {
               _loc2_.x = this._spaceLeft * this.getDepth(_loc2_);
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      protected function getDepth(param1:Object, param2:int = 0) : int
      {
         if(param1.nodeParent == null)
         {
            return param2;
         }
         return this.getDepth(param1.nodeParent,param2 + 1);
      }
      
      protected function getParentOpenStatus(param1:Object) : Boolean
      {
         var _loc2_:Object = param1.nodeParent;
         if(_loc2_ == null)
         {
            return true;
         }
         if(_loc2_.isOpen)
         {
            if(_loc2_.nodeParent != null)
            {
               return this.getParentOpenStatus(_loc2_);
            }
            return true;
         }
         return false;
      }
      
      private function renderItem(param1:Box, param2:int) : void
      {
         var _loc4_:Clip = null;
         var _loc5_:Clip = null;
         var _loc3_:Object = param1.dataSource;
         if(_loc3_)
         {
            param1.left = _loc3_.x;
            _loc4_ = param1.getChildByName("arrow") as Clip;
            if(_loc4_)
            {
               if(_loc3_.hasChild)
               {
                  _loc4_.visible = true;
                  _loc4_.frame = !!_loc3_.isOpen?1:0;
                  _loc4_.tag = param2;
                  _loc4_.addEventListener(MouseEvent.CLICK,this.onArrowClick);
               }
               else
               {
                  _loc4_.visible = false;
               }
            }
            _loc5_ = param1.getChildByName("folder") as Clip;
            if(_loc5_)
            {
               if(_loc5_.clipY == 2)
               {
                  _loc5_.frame = !!_loc3_.isDirectory?0:1;
               }
               else
               {
                  _loc5_.frame = !!_loc3_.isDirectory?!!_loc3_.isOpen?1:0:2;
               }
            }
            if(this._renderHandler != null)
            {
               this._renderHandler.executeWith([param1,param2]);
            }
         }
      }
      
      private function onArrowClick(param1:MouseEvent) : void
      {
         var _loc2_:Clip = param1.currentTarget as Clip;
         var _loc3_:int = int(_loc2_.tag);
         this._list.array[_loc3_].isOpen = !this._list.array[_loc3_].isOpen;
         this._list.array = this.getArray();
      }
      
      override public function set dataSource(param1:Object) : void
      {
         _dataSource = param1;
         if(param1 is XML)
         {
            this.xml = param1 as XML;
         }
         else
         {
            super.dataSource = param1;
         }
      }
      
      public function get xml() : XML
      {
         return this._xml;
      }
      
      public function set xml(param1:XML) : void
      {
         this._xml = param1;
         var _loc2_:Array = [];
         this.parseXml(this.xml,_loc2_,null,true);
         this.array = _loc2_;
      }
      
      protected function parseXml(param1:XML, param2:Array, param3:Object, param4:Boolean) : void
      {
         var _loc5_:Object = null;
         var _loc9_:XMLList = null;
         var _loc10_:XML = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:XML = null;
         var _loc6_:XMLList = param1.children();
         var _loc7_:int = _loc6_.length();
         if(!param4)
         {
            _loc5_ = {};
            _loc9_ = param1.attributes();
            for each(_loc10_ in _loc9_)
            {
               _loc11_ = _loc10_.name().toString();
               _loc12_ = _loc10_;
               _loc5_[_loc11_] = _loc12_ == "true"?true:_loc12_ == "false"?false:_loc12_;
            }
            _loc5_.nodeParent = param3;
            if(_loc7_ > 0)
            {
               _loc5_.isDirectory = true;
            }
            _loc5_.hasChild = _loc7_ > 0;
            param2.push(_loc5_);
         }
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc13_ = _loc6_[_loc8_];
            this.parseXml(_loc13_,param2,_loc5_,false);
            _loc8_++;
         }
      }
      
      protected function parseOpenStatus(param1:Array, param2:Array) : void
      {
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param2[_loc3_];
            if(_loc5_.isDirectory)
            {
               _loc6_ = 0;
               _loc7_ = param1.length;
               while(_loc6_ < _loc7_)
               {
                  _loc8_ = param1[_loc6_];
                  if(_loc8_.isDirectory && this.isSameParent(_loc8_,_loc5_) && _loc5_.label == _loc8_.label)
                  {
                     _loc5_.isOpen = _loc8_.isOpen;
                     break;
                  }
                  _loc6_++;
               }
            }
            _loc3_++;
         }
      }
      
      protected function isSameParent(param1:Object, param2:Object) : Boolean
      {
         if(param1.nodeParent == null && param2.nodeParent == null)
         {
            return true;
         }
         if(param1.nodeParent == null || param2.nodeParent == null)
         {
            return false;
         }
         if(param1.nodeParent.label == param2.nodeParent.label)
         {
            return this.isSameParent(param1.nodeParent,param2.nodeParent);
         }
         return false;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._list && this._list.dispose();
         this._list = null;
         this._source = null;
         this._xml = null;
         this._renderHandler = null;
      }
   }
}
