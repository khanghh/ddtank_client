package petsBag.petsAdvanced
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpBtnEnable;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import petsBag.PetsBagManager;
   
   public class PetsAdvancedFrame extends Frame
   {
       
      
      private var _hBox:HBox;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _breakHelpBtn:SimpleBitmapButton;
      
      private var _ringStarBtn:SelectedButton;
      
      private var _evolutionBtn:SelectedButton;
      
      private var _formBtn:SelectedButton;
      
      private var _eatPetsBtn:SelectedButton;
      
      private var _breakBtn:SelectedButton;
      
      private var _awakenBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _currentIndex:int;
      
      private var _view;
      
      public function PetsAdvancedFrame(){super();}
      
      private function initView() : void{}
      
      private function checkOpenType() : void{}
      
      public function setBtnEnableFalse() : void{}
      
      public function set enableBtn(param1:Boolean) : void{}
      
      private function addEvent() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      protected function __changeHandler(param1:Event) : void{}
      
      private function createHelpBtn(param1:String, param2:String, param3:Boolean) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
