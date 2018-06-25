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
      
      public function NumMovieSprite(powerNum:int, addPowerNum:int)
      {
         super();
         _powerNum = powerNum;
         _addPowerNum = addPowerNum;
         _allPowerNum = _powerNum + _addPowerNum;
         _powerString = String(_powerNum);
         _allPowerString = String(_allPowerNum);
         _iconArr = [];
         _iconArr2 = [];
         _moveNumArr = [];
         initView();
         addEventListener("enterFrame",__updateNumHandler);
      }
      
      protected function __updateNumHandler(event:Event) : void
      {
         var num:int = 0;
         var str:* = null;
         var k:int = 0;
         var num1:int = 0;
         var num2:int = 0;
         var i:int = 0;
         _frame = Number(_frame) + 1;
         if(_frame <= 10)
         {
            return;
         }
         if(_frame > 10 && _frame < 20)
         {
            str = _allPowerString.substr(_allPowerString.length - _powerString.length,_powerString.length);
            for(k = _powerString.length - 1; k >= 0; )
            {
               num1 = str.charAt(k);
               num2 = _powerString.charAt(k);
               if(num1 < num2)
               {
                  num1 = num1 + 10;
               }
               num = num1 - num2;
               _moveNumArr[k] = num;
               k--;
            }
            for(i = 0; i < _iconArr.length; )
            {
               if(_moveNumArr[i] > 0 && _moveNumArr[i] >= _frame - 10)
               {
                  (_iconArr[i] as MovieClip).gotoAndStop(_frame + 1 - 10);
               }
               else
               {
                  (_iconArr[i] as MovieClip).stop();
               }
               i++;
            }
         }
         else
         {
            var _loc10_:int = 0;
            var _loc9_:* = _iconArr2;
            for each(var item in _iconArr2)
            {
               addChild(item);
            }
            removeEventListener("enterFrame",__updateNumHandler);
         }
      }
      
      private function initView() : void
      {
         var k:int = 0;
         var powerNumMc2:* = null;
         var m:int = 0;
         var powerNumMc:* = null;
         var num:int = _allPowerString.length - _powerString.length;
         for(k = 0; k < _powerString.length; )
         {
            powerNumMc2 = ComponentFactory.Instance.creat("num" + _powerString.charAt(k));
            powerNumMc2.x = 210 + powerNumMc2.width / 1.6 * num + powerNumMc2.width / 1.6 * k;
            powerNumMc2.y = -28;
            addChild(powerNumMc2);
            powerNumMc2.stop();
            _iconArr.push(powerNumMc2);
            _moveNumArr.push(0);
            k++;
         }
         for(m = 0; m < num; )
         {
            powerNumMc = ComponentFactory.Instance.creat("num" + _allPowerString.charAt(m));
            powerNumMc.x = 210 + powerNumMc.width / 1.6 * num - powerNumMc.width / 1.6 * (num - m);
            powerNumMc.y = -28;
            powerNumMc.stop();
            _iconArr2.push(powerNumMc);
            m++;
         }
      }
      
      public function dispose() : void
      {
         var k:int = 0;
         var m:int = 0;
         for(k = 0; k < _iconArr.length; )
         {
            if(_iconArr[k])
            {
               ObjectUtils.disposeObject(_iconArr[k]);
               _iconArr[k] = null;
            }
            k++;
         }
         _iconArr = null;
         for(m = 0; m < _iconArr2.length; )
         {
            if(_iconArr2[m])
            {
               ObjectUtils.disposeObject(_iconArr2[m]);
               _iconArr2[m] = null;
            }
            m++;
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
