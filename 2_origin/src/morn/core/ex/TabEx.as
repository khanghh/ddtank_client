package morn.core.ex
{
   import flash.display.DisplayObject;
   
   public class TabEx extends GroupEx
   {
      
      public static const HORIZENTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      protected var _offset:String;
      
      public function TabEx(param1:String = null, param2:String = null)
      {
         super(param1,param2);
         _direction = HORIZENTAL;
      }
      
      override protected function createItem(param1:String, param2:String) : DisplayObject
      {
         return new ButtonEx(param1,param2);
      }
      
      public function set offset(param1:String) : void
      {
         if(this._offset != param1)
         {
            this._offset = param1;
            callLater(this.changeImageLabels);
         }
      }
      
      public function get offset() : String
      {
         return this._offset;
      }
      
      override protected function changeImageLabels() : void
      {
         var _loc1_:* = NaN;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:* = NaN;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:ButtonEx = null;
         if(_items)
         {
            _loc1_ = 0;
            _loc2_ = imageLabels.split(",");
            _loc3_ = _skin.split(",");
            _loc4_ = !!this._offset?this._offset.split(","):[];
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = _items.length;
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _items[_loc6_] as ButtonEx;
               if(_loc3_ && _loc3_.length > _loc6_)
               {
                  _loc8_.skin = _loc3_[_loc6_];
               }
               if(_loc2_ && _loc2_.length > _loc6_)
               {
                  _loc8_.imageLabel = _loc2_[_loc6_];
               }
               if(_loc4_ && _loc4_.length > _loc6_)
               {
                  _loc5_ = Number(_loc4_[_loc6_]);
               }
               if(_direction == HORIZENTAL)
               {
                  _loc8_.y = 0;
                  _loc8_.x = _loc1_;
                  _loc1_ = Number(_loc1_ + (_loc8_.width + _space + _loc5_));
               }
               else
               {
                  _loc8_.x = 0;
                  _loc8_.y = _loc1_;
                  _loc1_ = Number(_loc1_ + (_loc8_.height + _space + _loc5_));
               }
               _loc6_++;
            }
         }
      }
   }
}
