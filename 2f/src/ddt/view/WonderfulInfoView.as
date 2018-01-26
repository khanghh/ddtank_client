package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WonderfulInfoView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MovieClip;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _title:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _okBtn:SimpleBitmapButton;
      
      public function WonderfulInfoView(){super();}
      
      private function initView() : void{}
      
      public function show(param1:int, param2:String, param3:String) : void{}
      
      private function initEvent() : void{}
      
      protected function __onCloseClickHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
