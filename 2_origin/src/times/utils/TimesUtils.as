package times.utils
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import times.TimesController;
   import times.data.TimesEvent;
   import times.data.TimesPicInfo;
   
   public class TimesUtils
   {
      
      private static var _reg:RegExp = /\{(\d+)\}/;
       
      
      public function TimesUtils()
      {
         super();
      }
      
      public static function setPos(param1:*, param2:String) : void
      {
         var _loc3_:Point = ComponentFactory.Instance.creatCustomObject(param2);
         param1.x = _loc3_.x;
         param1.y = _loc3_.y;
      }
      
      public static function getWords(param1:String, ... rest) : String
      {
         var _loc3_:int = 0;
         var _loc6_:XML = ComponentFactory.Instance.getCustomStyle(param1);
         var _loc4_:String = _loc6_.@value;
         var _loc5_:Object = _reg.exec(_loc4_);
         while(_loc5_ && rest.length > 0)
         {
            _loc3_ = _loc5_[1];
            if(_loc3_ >= 0 && _loc3_ < rest.length)
            {
               _loc4_ = _loc4_.replace(_reg,rest[_loc3_]);
            }
            else
            {
               _loc4_ = _loc4_.replace(_reg,"{}");
            }
            _loc5_ = _reg.exec(_loc4_);
         }
         return _loc4_;
      }
      
      public static function createCell(param1:Loader, param2:TimesPicInfo) : Array
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc12_:* = null;
         var _loc7_:int = 0;
         var _loc10_:* = null;
         var _loc11_:* = undefined;
         var _loc9_:int = 0;
         var _loc4_:* = undefined;
         var _loc8_:* = null;
         var _loc6_:* = null;
         if(param1 && param1.content as MovieClip)
         {
            _loc5_ = param1.content as MovieClip;
            _loc7_ = _loc5_.numChildren;
            _loc11_ = getDefinitionByName("bagAndInfo.cell.CellFactory");
            _loc9_ = 0;
            while(_loc9_ < _loc7_)
            {
               _loc12_ = _loc5_.getChildAt(_loc9_) as MovieClip;
               if(_loc12_ != null)
               {
                  _loc10_ = _loc12_.name;
                  if(_loc10_.substr(0,4) == "good")
                  {
                     if(!_loc3_)
                     {
                        _loc3_ = [];
                     }
                     _loc8_ = new Shape();
                     _loc8_.graphics.lineStyle(1,16777215,0);
                     _loc8_.graphics.drawRect(0,0,_loc12_.width,_loc12_.height);
                     _loc4_ = _loc11_.instance.createWeeklyItemCell(_loc8_,_loc10_.substr(5));
                     _loc4_.x = _loc12_.x;
                     _loc4_.y = _loc12_.y;
                     _loc4_.alpha = 0;
                     _loc3_.push(_loc4_);
                  }
                  else if(_loc10_.substr(0,8) == "purchase")
                  {
                     TimesController.Instance.dispatchEvent(new TimesEvent("pushTipItems",param2,[_loc12_]));
                     if(!_loc3_)
                     {
                        _loc3_ = [];
                     }
                     _loc6_ = new Shape();
                     _loc6_.graphics.lineStyle(1,16777215,0);
                     _loc6_.graphics.drawRect(0,0,_loc12_.width,_loc12_.height);
                     _loc4_ = _loc11_.instance.createWeeklyItemCell(_loc6_,_loc10_.substr(9));
                     _loc4_.name = _loc10_.substr(9);
                     _loc4_.x = _loc12_.x;
                     _loc4_.y = _loc12_.y;
                     _loc4_.alpha = 0;
                     _loc4_.addEventListener("click",quickBuy);
                     _loc4_.buttonMode = true;
                     _loc3_.push(_loc4_);
                  }
               }
               _loc9_++;
            }
         }
         var _loc13_:int = 0;
         if(_loc5_ && _loc3_ && _loc3_.length > 0)
         {
            while(_loc5_.numChildren == _loc7_ && _loc7_ > _loc13_)
            {
               if(_loc5_.getChildAt(_loc13_).name.substr(0,4) == "good")
               {
                  _loc5_.removeChildAt(_loc13_);
                  _loc7_--;
               }
               else
               {
                  _loc13_++;
               }
            }
         }
         if(_loc3_)
         {
            TimesController.Instance.dispatchEvent(new TimesEvent("pushTipCells",param2,_loc3_));
         }
         return _loc3_;
      }
      
      private static function quickBuy(param1:MouseEvent) : void
      {
         var _loc2_:TimesPicInfo = new TimesPicInfo();
         _loc2_.templateID = int(param1.currentTarget.name);
         TimesController.Instance.dispatchEvent(new TimesEvent("purchase",_loc2_));
      }
   }
}
