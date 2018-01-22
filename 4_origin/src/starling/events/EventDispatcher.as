package starling.events
{
   import flash.utils.Dictionary;
   import starling.display.DisplayObject;
   
   public class EventDispatcher
   {
      
      private static var sBubbleChains:Array = [];
       
      
      private var mEventListeners:Dictionary;
      
      public function EventDispatcher()
      {
         super();
      }
      
      public function addEventListener(param1:String, param2:Function) : void
      {
         if(mEventListeners == null)
         {
            mEventListeners = new Dictionary();
         }
         var _loc3_:Vector.<Function> = mEventListeners[param1] as Vector.<Function>;
         if(_loc3_ == null)
         {
            mEventListeners[param1] = new <Function>[param2];
         }
         else if(_loc3_.indexOf(param2) == -1)
         {
            _loc3_[_loc3_.length] = param2;
         }
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         var _loc3_:* = undefined;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:int = 0;
         var _loc5_:* = null;
         if(mEventListeners)
         {
            _loc3_ = mEventListeners[param1] as Vector.<Function>;
            _loc6_ = !!_loc3_?_loc3_.length:0;
            if(_loc6_ > 0)
            {
               _loc4_ = 0;
               _loc7_ = new Vector.<Function>(_loc6_ - 1);
               _loc8_ = 0;
               while(_loc8_ < _loc6_)
               {
                  _loc5_ = _loc3_[_loc8_];
                  if(_loc5_ != param2)
                  {
                     _loc4_++;
                     _loc7_[int(_loc4_)] = _loc5_;
                  }
                  _loc8_++;
               }
               mEventListeners[param1] = _loc7_;
            }
         }
      }
      
      public function removeEventListeners(param1:String = null) : void
      {
         if(param1 && mEventListeners)
         {
            delete mEventListeners[param1];
         }
         else
         {
            mEventListeners = null;
         }
      }
      
      public function dispatchEvent(param1:Event) : void
      {
         var _loc3_:Boolean = param1.bubbles;
         if(!_loc3_ && (mEventListeners == null || !(param1.type in mEventListeners)))
         {
            return;
         }
         var _loc2_:EventDispatcher = param1.target;
         param1.setTarget(this);
         if(_loc3_ && this is DisplayObject)
         {
            bubbleEvent(param1);
         }
         else
         {
            invokeEvent(param1);
         }
         if(_loc2_)
         {
            param1.setTarget(_loc2_);
         }
      }
      
      function invokeEvent(param1:Event) : Boolean
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc2_:Vector.<Function> = !!mEventListeners?mEventListeners[param1.type] as Vector.<Function>:null;
         var _loc4_:int = _loc2_ == null?0:_loc2_.length;
         if(_loc4_)
         {
            param1.setCurrentTarget(this);
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc3_ = _loc2_[_loc6_] as Function;
               _loc5_ = _loc3_.length;
               if(_loc5_ == 0)
               {
                  _loc3_();
               }
               else if(_loc5_ == 1)
               {
                  _loc3_(param1);
               }
               else
               {
                  _loc3_(param1,param1.data);
               }
               if(param1.stopsImmediatePropagation)
               {
                  return true;
               }
               _loc6_++;
            }
            return param1.stopsPropagation;
         }
         return false;
      }
      
      function bubbleEvent(param1:Event) : void
      {
         var _loc3_:* = undefined;
         var _loc6_:int = 0;
         var _loc4_:Boolean = false;
         var _loc2_:DisplayObject = this as DisplayObject;
         var _loc5_:int = 1;
         if(sBubbleChains.length > 0)
         {
            _loc3_ = sBubbleChains.pop();
            _loc3_[0] = _loc2_;
         }
         else
         {
            _loc3_ = new <EventDispatcher>[_loc2_];
         }
         while(true)
         {
            _loc2_ = _loc2_.parent;
            if(_loc2_.parent == null)
            {
               break;
            }
            _loc5_++;
            _loc3_[int(_loc5_)] = _loc2_;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = _loc3_[_loc6_].invokeEvent(param1);
            if(!_loc4_)
            {
               _loc6_++;
               continue;
            }
            break;
         }
         _loc3_.length = 0;
         sBubbleChains[sBubbleChains.length] = _loc3_;
      }
      
      public function dispatchEventWith(param1:String, param2:Boolean = false, param3:Object = null) : void
      {
         var _loc4_:* = null;
         if(param2 || hasEventListener(param1))
         {
            _loc4_ = Event.fromPool(param1,param2,param3);
            dispatchEvent(_loc4_);
            Event.toPool(_loc4_);
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         var _loc2_:Vector.<Function> = !!mEventListeners?mEventListeners[param1]:null;
         return !!_loc2_?_loc2_.length != 0:false;
      }
   }
}
