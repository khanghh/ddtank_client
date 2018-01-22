package anotherDimension.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class AnotherDimensionProgress extends Sprite implements Disposeable
   {
       
      
      private var _progressMc:MovieClip;
      
      private var _loop:int;
      
      private var _nextFrameIndex:int;
      
      private var _progressTxt:FilterFrameText;
      
      public function AnotherDimensionProgress()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _progressMc = ComponentFactory.Instance.creat("anotherDimension.progress");
         addChild(_progressMc);
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.progress.progressTxt");
         _progressTxt.text = "0/0";
         addChild(_progressTxt);
         _progressMc.stop();
      }
      
      public function setProgressTxt(param1:String) : void
      {
         _progressTxt.text = param1;
      }
      
      private function initEvent() : void
      {
         addEventListener("enterFrame",_checkFrame);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",_checkFrame);
      }
      
      private function _checkFrame(param1:Event) : void
      {
         if(_nextFrameIndex == _progressMc.currentFrame)
         {
            if(_loop > 0)
            {
               _loop = Number(_loop) - 1;
            }
            if(_loop == 0)
            {
               _progressMc.stop();
               dispatchEvent(new Event("mcStop"));
               _loop = 0;
            }
         }
      }
      
      public function setProgress(param1:int) : void
      {
         _progressMc.gotoAndStop(param1);
      }
      
      public function playProgress(param1:int, param2:int = 0) : void
      {
         if(_progressMc.currentFrame >= param1 && param2 == 0)
         {
            _progressMc.stop();
            dispatchEvent(new Event("mcStop"));
            return;
         }
         _progressMc.play();
         _nextFrameIndex = param1;
         _loop = param2;
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
