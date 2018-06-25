package powerUp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PowerSprite extends Sprite implements Disposeable
   {
       
      
      private var _powerBgMc:MovieClip;
      
      private var _greenAddIcon:MovieClip;
      
      private var _lineMc1:MovieClip;
      
      private var _frameNum:int;
      
      private var _addPowerNum:int;
      
      private var _powerNum:int;
      
      private var _numMovieSprite:NumMovieSprite;
      
      private var _greenIconArr:Array;
      
      public function PowerSprite(powerNum:int, addPowerNum:int)
      {
         super();
         if(powerNum < 0)
         {
            powerNum = 0;
         }
         if(addPowerNum < 0)
         {
            addPowerNum = 0;
         }
         _powerNum = powerNum;
         _addPowerNum = addPowerNum;
         _greenIconArr = [];
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var k:int = 0;
         var powerNumMc:* = null;
         _powerBgMc = ComponentFactory.Instance.creat("powerBg");
         _powerBgMc.x = 30;
         _powerBgMc.y = 200;
         addChild(_powerBgMc);
         _lineMc1 = ComponentFactory.Instance.creat("powerLine");
         _greenAddIcon = ComponentFactory.Instance.creat("greenAddIcon");
         var addPowerString:String = String(_addPowerNum);
         _greenIconArr.push(_greenAddIcon);
         _greenIconArr[0].x = 270;
         _greenIconArr[0].y = -23;
         _greenIconArr[0].alpha = 0;
         _powerBgMc.addChild(_greenIconArr[0]);
         for(k = 0; k < addPowerString.length; )
         {
            powerNumMc = ComponentFactory.Instance.creat("greenNum" + addPowerString.charAt(k));
            powerNumMc.x = 290 + powerNumMc.width / 1.1 * k;
            powerNumMc.y = -28;
            powerNumMc.alpha = 0;
            _powerBgMc.addChild(powerNumMc);
            _greenIconArr.push(powerNumMc);
            k++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("enterFrame",__updatePowerMcHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__updatePowerMcHandler);
      }
      
      protected function __updatePowerMcHandler(event:Event) : void
      {
         var i:int = 0;
         var j:int = 0;
         if(_frameNum < 41)
         {
            _frameNum = Number(_frameNum) + 1;
            if(_frameNum > 5 && _frameNum < 25)
            {
               if(_frameNum == 15)
               {
                  _numMovieSprite = new NumMovieSprite(_powerNum,_addPowerNum);
                  _powerBgMc.addChild(_numMovieSprite);
               }
               i = 0;
               while(i < _greenIconArr.length)
               {
                  (_greenIconArr[i] as MovieClip).y = (_greenIconArr[i] as MovieClip).y - 4;
                  (_greenIconArr[i] as MovieClip).alpha = (_greenIconArr[i] as MovieClip).alpha + 0.05;
                  i++;
               }
            }
            else if(_frameNum > 26 && _frameNum < 37)
            {
               for(j = 0; j < _greenIconArr.length; )
               {
                  (_greenIconArr[j] as MovieClip).y = (_greenIconArr[j] as MovieClip).y - 3;
                  (_greenIconArr[j] as MovieClip).alpha = (_greenIconArr[j] as MovieClip).alpha - 0.1;
                  j++;
               }
            }
            else if(_frameNum == 40)
            {
               _lineMc1.x = _powerBgMc.x - 20;
               _lineMc1.y = _powerBgMc.y - 73;
               addChild(_lineMc1);
            }
         }
         else
         {
            dispatchEvent(new Event("powerUpMovieOver"));
            removeEvent();
         }
      }
      
      public function dispose() : void
      {
         var k:int = 0;
         ObjectUtils.disposeObject(_powerBgMc);
         _powerBgMc = null;
         ObjectUtils.disposeObject(_lineMc1);
         _lineMc1 = null;
         for(k = 0; k < _greenIconArr.length; )
         {
            if(_greenIconArr[k])
            {
               ObjectUtils.disposeObject(_greenIconArr[k]);
               _greenIconArr[k] = null;
            }
            k++;
         }
         _greenIconArr = null;
         ObjectUtils.disposeObject(_numMovieSprite);
         _numMovieSprite = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
