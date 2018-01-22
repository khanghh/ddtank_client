package powerUp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class NumMovieSprite extends Sprite implements Disposeable
   {
       
      
      private var _powerNum:int;
      
      private var _powerString:String;
      
      private var _addPowerNum:int;
      
      private var _allPowerNum:int;
      
      private var _allPowerString:String;
      
      private var _iconArr:Array;
      
      private var _iconArr2:Array;
      
      private var _moveNumArr:Array;
      
      private var _frame:int;
      
      public function NumMovieSprite(param1:int, param2:int)
      {
         super();
         _powerNum = param1;
         _addPowerNum = param2;
         _allPowerNum = _powerNum + _addPowerNum;
         _powerString = String(_powerNum);
         _allPowerString = String(_allPowerNum);
         _iconArr = [];
         _iconArr2 = [];
         _moveNumArr = [];
         initView();
         addEventListener("enterFrame",__updateNumHandler);
      }
      
      protected function __updateNumHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         _frame = Number(_frame) + 1;
         if(_frame <= 10)
         {
            return;
         }
         if(_frame > 10 && _frame < 20)
         {
            _loc3_ = _allPowerString.substr(_allPowerString.length - _powerString.length,_powerString.length);
            _loc7_ = _powerString.length - 1;
            while(_loc7_ >= 0)
            {
               _loc6_ = _loc3_.charAt(_loc7_);
               _loc5_ = _powerString.charAt(_loc7_);
               if(_loc6_ < _loc5_)
               {
                  _loc6_ = _loc6_ + 10;
               }
               _loc2_ = _loc6_ - _loc5_;
               _moveNumArr[_loc7_] = _loc2_;
               _loc7_--;
            }
            _loc8_ = 0;
            while(_loc8_ < _iconArr.length)
            {
               if(_moveNumArr[_loc8_] > 0 && _moveNumArr[_loc8_] >= _frame - 10)
               {
                  (_iconArr[_loc8_] as MovieClip).gotoAndStop(_frame + 1 - 10);
               }
               else
               {
                  (_iconArr[_loc8_] as MovieClip).stop();
               }
               _loc8_++;
            }
         }
         else
         {
            var _loc10_:int = 0;
            var _loc9_:* = _iconArr2;
            for each(var _loc4_ in _iconArr2)
            {
               addChild(_loc4_);
            }
            removeEventListener("enterFrame",__updateNumHandler);
         }
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc1_:int = _allPowerString.length - _powerString.length;
         _loc3_ = 0;
         while(_loc3_ < _powerString.length)
         {
            _loc5_ = ComponentFactory.Instance.creat("num" + _powerString.charAt(_loc3_));
            _loc5_.x = 210 + _loc5_.width / 1.6 * _loc1_ + _loc5_.width / 1.6 * _loc3_;
            _loc5_.y = -28;
            addChild(_loc5_);
            _loc5_.stop();
            _iconArr.push(_loc5_);
            _moveNumArr.push(0);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = ComponentFactory.Instance.creat("num" + _allPowerString.charAt(_loc2_));
            _loc4_.x = 210 + _loc4_.width / 1.6 * _loc1_ - _loc4_.width / 1.6 * (_loc1_ - _loc2_);
            _loc4_.y = -28;
            _loc4_.stop();
            _iconArr2.push(_loc4_);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _iconArr.length)
         {
            if(_iconArr[_loc2_])
            {
               ObjectUtils.disposeObject(_iconArr[_loc2_]);
               _iconArr[_loc2_] = null;
            }
            _loc2_++;
         }
         _iconArr = null;
         _loc1_ = 0;
         while(_loc1_ < _iconArr2.length)
         {
            if(_iconArr2[_loc1_])
            {
               ObjectUtils.disposeObject(_iconArr2[_loc1_]);
               _iconArr2[_loc1_] = null;
            }
            _loc1_++;
         }
         _iconArr2 = null;
         _moveNumArr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
