package godsRoads.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import godsRoads.manager.GodsRoadsManager;
   
   public class GodsRoadsFlag extends Component
   {
       
      
      private var _lv:int = 1;
      
      private var _alertTxt:FilterFrameText;
      
      private var _btn:BaseButton;
      
      private var _numBitmapArray:Array;
      
      private var _pointsNum:Sprite;
      
      private var _offX:int = 6;
      
      private var _perBmp:Bitmap;
      
      private var progressTxt:Bitmap;
      
      private var isOpen:Boolean = false;
      
      private var _progressNum:int;
      
      public function GodsRoadsFlag(param1:int){super();}
      
      private function initView() : void{}
      
      public function set enable(param1:Boolean) : void{}
      
      public function get isOpened() : Boolean{return false;}
      
      private function getFA(param1:String) : Array{return null;}
      
      private function __changeSteps(param1:MouseEvent) : void{}
      
      public function get enable() : Boolean{return false;}
      
      public function set progressNum(param1:int) : void{}
      
      public function get progressNum() : int{return 0;}
      
      public function set showProgress(param1:Boolean) : void{}
      
      private function setCountDownNumber(param1:int) : void{}
      
      private function deleteBitmapArray() : void{}
   }
}
