package dice.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import dice.controller.DiceController;
   import dice.event.DiceEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class DiceStartView extends Sprite implements Disposeable
   {
       
      
      private var _type:int;
      
      private var _result:int;
      
      private var _leftArr:Array;
      
      private var _rightArr:Array;
      
      private var _rule:Array;
      
      private var _left:int;
      
      private var _right:int;
      
      public function DiceStartView()
      {
         _leftArr = [];
         _rightArr = [];
         _rule = [];
         super();
         preInitialize();
      }
      
      public function play(param1:int, param2:int) : void
      {
         _type = param1;
         _result = param2;
         if(_type == 1)
         {
            _left = int(Math.random() * 6) + 1;
            if(_left >= param2)
            {
               _left = 1;
            }
            if(_result - _left >= 7)
            {
               _right = _result - 6;
               _left = _result - _right;
            }
            else
            {
               _right = _result - _left;
            }
            _leftArr[_left - 1].addEventListener("enterFrame",__onEnterFrame);
            _leftArr[_left - 1].gotoAndPlay(2);
            _rightArr[_right - 1].gotoAndPlay(2);
            addChild(_leftArr[_left - 1]);
            addChild(_rightArr[_right - 1]);
         }
         else
         {
            _left = _result;
            _leftArr[_left - 1].addEventListener("enterFrame",__onEnterFrame);
            _leftArr[_left - 1].gotoAndPlay(2);
            addChild(_leftArr[_left - 1]);
         }
      }
      
      private function __onEnterFrame(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentLabel == "endLabel")
         {
            DiceController.Instance.dispatchEvent(new DiceEvent("movie_finish"));
            _loc2_.removeEventListener("enterFrame",__onEnterFrame);
            _loc2_.stop();
         }
      }
      
      public function removeAllMovie() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _leftArr.length)
         {
            if(_leftArr[_loc1_].parent)
            {
               removeChild(_leftArr[_loc1_]);
            }
            if(_rightArr[_loc1_].parent)
            {
               removeChild(_rightArr[_loc1_]);
            }
            _loc1_++;
         }
      }
      
      private function preInitialize() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _leftArr[_loc1_] = ComponentFactory.Instance.creat("asset.dice.movie" + (_loc1_ + 1));
            _leftArr[_loc1_].x = 50;
            _rightArr[_loc1_] = ComponentFactory.Instance.creat("asset.dice.movie" + (_loc1_ + 7));
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_rightArr[0]);
         _rightArr[0] = null;
         ObjectUtils.disposeObject(_rightArr[1]);
         _rightArr[1] = null;
         ObjectUtils.disposeObject(_rightArr[2]);
         _rightArr[2] = null;
         ObjectUtils.disposeObject(_rightArr[3]);
         _rightArr[3] = null;
         ObjectUtils.disposeObject(_rightArr[4]);
         _rightArr[4] = null;
         ObjectUtils.disposeObject(_rightArr[5]);
         _rightArr[5] = null;
         ObjectUtils.disposeObject(_leftArr[0]);
         _leftArr[0] = null;
         ObjectUtils.disposeObject(_leftArr[1]);
         _leftArr[1] = null;
         ObjectUtils.disposeObject(_leftArr[2]);
         _leftArr[2] = null;
         ObjectUtils.disposeObject(_leftArr[3]);
         _leftArr[3] = null;
         ObjectUtils.disposeObject(_leftArr[4]);
         _leftArr[4] = null;
         ObjectUtils.disposeObject(_leftArr[5]);
         _leftArr[5] = null;
      }
   }
}
