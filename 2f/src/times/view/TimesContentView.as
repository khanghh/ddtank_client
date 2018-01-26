package times.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import times.TimesController;
   import times.data.TimesEvent;
   import times.data.TimesPicInfo;
   import times.utils.TimesUtils;
   
   public class TimesContentView extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _controller:TimesController;
      
      private var _bigPics:TimesPicGroup;
      
      private var _prePageBtn:SimpleBitmapButton;
      
      private var _nextPageBtn:SimpleBitmapButton;
      
      private var _maskShape:Shape;
      
      private var _maxIdx:int;
      
      private var _picType:String;
      
      public function TimesContentView(param1:int){super();}
      
      public function init(param1:Vector.<TimesPicInfo>) : void{}
      
      public function get maxIdx() : int{return 0;}
      
      public function set maxIdx(param1:int) : void{}
      
      public function set frame(param1:int) : void{}
      
      public function get frame() : int{return 0;}
      
      private function load(param1:int) : void{}
      
      private function initEvent() : void{}
      
      private function __onBtnClick(param1:MouseEvent) : void{}
      
      private function goPrePage() : void{}
      
      private function goNextPage() : void{}
      
      public function dispose() : void{}
   }
}
