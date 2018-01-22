package store.view.transfer
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   
   public class HoleConfirmAlert extends BaseAlerFrame
   {
       
      
      private var _state1:Boolean;
      
      private var _state2:Boolean;
      
      private var _beforeCheck:SelectedCheckButton;
      
      private var _afterCheck:SelectedCheckButton;
      
      private var _textField:FilterFrameText;
      
      private var _noteField:FilterFrameText;
      
      public function HoleConfirmAlert(param1:int, param2:int){super();}
      
      override protected function init() : void{}
      
      private function addEvent() : void{}
      
      private function __selectChanged(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      public function get state1() : Boolean{return false;}
      
      public function get state2() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
