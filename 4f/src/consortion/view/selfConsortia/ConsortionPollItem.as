package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortionPollInfo;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ConsortionPollItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _name:FilterFrameText;
      
      private var _count:FilterFrameText;
      
      private var _info:ConsortionPollInfo;
      
      private var _selected:Boolean;
      
      private var _index:int;
      
      public function ConsortionPollItem(param1:int){super();}
      
      private function initView() : void{}
      
      override public function get height() : Number{return 0;}
      
      public function set info(param1:ConsortionPollInfo) : void{}
      
      public function get info() : ConsortionPollInfo{return null;}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __selectHandler(param1:MouseEvent) : void{}
      
      private function __overHandler(param1:MouseEvent) : void{}
      
      private function __outHandler(param1:MouseEvent) : void{}
      
      public function set selected(param1:Boolean) : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function dispose() : void{}
   }
}
