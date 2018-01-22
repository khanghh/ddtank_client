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
      
      public function PowerSprite(param1:int, param2:int)
      {
         super();
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         _powerNum = param1;
         _addPowerNum = param2;
         _greenIconArr = [];
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         _powerBgMc = ComponentFactory.Instance.creat("powerBg");
         _powerBgMc.x = 30;
         _powerBgMc.y = 200;
         addChild(_powerBgMc);
         _lineMc1 = ComponentFactory.Instance.creat("powerLine");
         _greenAddIcon = ComponentFactory.Instance.creat("greenAddIcon");
         var _loc1_:String = String(_addPowerNum);
         _greenIconArr.push(_greenAddIcon);
         _greenIconArr[0].x = 270;
         _greenIconArr[0].y = -23;
         _greenIconArr[0].alpha = 0;
         _powerBgMc.addChild(_greenIconArr[0]);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = ComponentFactory.Instance.creat("greenNum" + _loc1_.charAt(_loc2_));
            _loc3_.x = 290 + _loc3_.width / 1.1 * _loc2_;
            _loc3_.y = -28;
            _loc3_.alpha = 0;
            _powerBgMc.addChild(_loc3_);
            _greenIconArr.push(_loc3_);
            _loc2_++;
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
      
      protected function __updatePowerMcHandler(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
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
               _loc3_ = 0;
               while(_loc3_ < _greenIconArr.length)
               {
                  (_greenIconArr[_loc3_] as MovieClip).y = (_greenIconArr[_loc3_] as MovieClip).y - 4;
                  (_greenIconArr[_loc3_] as MovieClip).alpha = (_greenIconArr[_loc3_] as MovieClip).alpha + 0.05;
                  _loc3_++;
               }
            }
            else if(_frameNum > 26 && _frameNum < 37)
            {
               _loc2_ = 0;
               while(_loc2_ < _greenIconArr.length)
               {
                  (_greenIconArr[_loc2_] as MovieClip).y = (_greenIconArr[_loc2_] as MovieClip).y - 3;
                  (_greenIconArr[_loc2_] as MovieClip).alpha = (_greenIconArr[_loc2_] as MovieClip).alpha - 0.1;
                  _loc2_++;
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
         var _loc1_:int = 0;
         ObjectUtils.disposeObject(_powerBgMc);
         _powerBgMc = null;
         ObjectUtils.disposeObject(_lineMc1);
         _lineMc1 = null;
         _loc1_ = 0;
         while(_loc1_ < _greenIconArr.length)
         {
            if(_greenIconArr[_loc1_])
            {
               ObjectUtils.disposeObject(_greenIconArr[_loc1_]);
               _greenIconArr[_loc1_] = null;
            }
            _loc1_++;
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
