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
      
      public function AnotherDimensionProgress(){super();}
      
      private function initView() : void{}
      
      public function setProgressTxt(param1:String) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function _checkFrame(param1:Event) : void{}
      
      public function setProgress(param1:int) : void{}
      
      public function playProgress(param1:int, param2:int = 0) : void{}
      
      public function dispose() : void{}
   }
}
