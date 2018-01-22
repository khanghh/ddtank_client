package morn.core.components
{
   import flash.display.DisplayObject;
   import morn.editor.core.IBox;
   
   public class Box extends Component implements IBox
   {
       
      
      public function Box()
      {
         super();
      }
      
      override protected function preinitialize() : void
      {
         mouseChildren = true;
      }
      
      public function addElement(param1:DisplayObject, param2:Number, param3:Number) : void
      {
         param1.x = param2;
         param1.y = param3;
         addChild(param1);
      }
      
      public function addElementAt(param1:DisplayObject, param2:int, param3:Number, param4:Number) : void
      {
         param1.x = param3;
         param1.y = param4;
         addChildAt(param1,param2);
      }
      
      public function addElements(param1:Array) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc2_:int = 0;
         var _loc3_:int = param1.length;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1[_loc2_];
            addChild(_loc4_);
            _loc2_++;
         }
      }
      
      public function removeElement(param1:DisplayObject) : void
      {
         if(param1 && contains(param1))
         {
            removeChild(param1);
         }
      }
      
      public function removeAllChild(param1:DisplayObject = null) : void
      {
         var _loc2_:int = numChildren - 1;
         while(_loc2_ > -1)
         {
            if(param1 != getChildAt(_loc2_))
            {
               removeChildAt(_loc2_);
            }
            _loc2_--;
         }
      }
      
      public function insertAbove(param1:DisplayObject, param2:DisplayObject) : void
      {
         this.removeElement(param1);
         var _loc3_:int = getChildIndex(param2);
         addChildAt(param1,Math.min(_loc3_ + 1,numChildren));
      }
      
      public function insertBelow(param1:DisplayObject, param2:DisplayObject) : void
      {
         this.removeElement(param1);
         var _loc3_:int = getChildIndex(param2);
         addChildAt(param1,Math.max(_loc3_,0));
      }
      
      override public function set dataSource(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:Component = null;
         _dataSource = param1;
         for(_loc2_ in param1)
         {
            _loc3_ = getChildByName(_loc2_) as Component;
            if(_loc3_)
            {
               _loc3_.dataSource = param1[_loc2_];
            }
            else if(hasOwnProperty(_loc2_))
            {
               this[_loc2_] = param1[_loc2_];
            }
         }
      }
   }
}
