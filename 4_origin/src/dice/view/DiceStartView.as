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
      
      public function play(type:int, result:int) : void
      {
         _type = type;
         _result = result;
         if(_type == 1)
         {
            _left = int(Math.random() * 6) + 1;
            if(_left >= result)
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
      
      private function __onEnterFrame(event:Event) : void
      {
         var _target:MovieClip = event.currentTarget as MovieClip;
         if(_target.currentLabel == "endLabel")
         {
            DiceController.Instance.dispatchEvent(new DiceEvent("movie_finish"));
            _target.removeEventListener("enterFrame",__onEnterFrame);
            _target.stop();
         }
      }
      
      public function removeAllMovie() : void
      {
         var i:int = 0;
         for(i = 0; i < _leftArr.length; )
         {
            if(_leftArr[i].parent)
            {
               removeChild(_leftArr[i]);
            }
            if(_rightArr[i].parent)
            {
               removeChild(_rightArr[i]);
            }
            i++;
         }
      }
      
      private function preInitialize() : void
      {
         var i:int = 0;
         for(i = 0; i < 6; )
         {
            _leftArr[i] = ComponentFactory.Instance.creat("asset.dice.movie" + (i + 1));
            _leftArr[i].x = 50;
            _rightArr[i] = ComponentFactory.Instance.creat("asset.dice.movie" + (i + 7));
            i++;
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
