package starlingui.core.components
{
   import starling.display.DisplayObject;
   import starlingui.editor.core.IBox;
   
   public class Box extends Component implements IBox
   {
       
      
      public function Box()
      {
         super();
      }
      
      override protected function preinitialize() : void
      {
         touchable = false;
      }
      
      public function addElement(param1:DisplayObject, param2:Number = 0, param3:Number = 0) : void
      {
         param1.x = param2;
         param1.y = param3;
         addChild(param1);
      }
      
      public function addElementAt(param1:DisplayObject, param2:int, param3:Number = 0, param4:Number = 0) : void
      {
         param1.x = param3;
         param1.y = param4;
         addChildAt(param1,param2);
      }
      
      public function addElements(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc4_ = 0;
         _loc3_ = param1.length;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1[_loc4_];
            addChild(_loc2_);
            _loc4_++;
         }
      }
      
      public function removeElement(param1:DisplayObject, param2:Boolean = false) : void
      {
         if(param1 && contains(param1))
         {
            removeChild(param1,param2);
         }
      }
      
      public function removeAllChild(param1:DisplayObject = null, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         _loc3_ = numChildren - 1;
         while(_loc3_ > -1)
         {
            if(param1 != getChildAt(_loc3_))
            {
               removeChildAt(_loc3_,param2);
            }
            _loc3_--;
         }
      }
      
      public function insertAbove(param1:DisplayObject, param2:DisplayObject) : void
      {
         removeElement(param1);
         var _loc3_:int = getChildIndex(param2);
         addChildAt(param1,Math.min(_loc3_ + 1,numChildren));
      }
      
      public function insertBelow(param1:DisplayObject, param2:DisplayObject) : void
      {
         removeElement(param1);
         var _loc3_:int = getChildIndex(param2);
         addChildAt(param1,Math.max(_loc3_,0));
      }
      
      override public function set dataSource(param1:Object) : void
      {
         var _loc2_:* = null;
         _dataSource = param1;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(var _loc3_ in param1)
         {
            _loc2_ = getChildByName(_loc3_) as Component;
            if(_loc2_)
            {
               _loc2_.dataSource = param1[_loc3_];
            }
            else if(hasOwnProperty(_loc3_))
            {
               this[_loc3_] = param1[_loc3_];
            }
         }
      }
   }
}
