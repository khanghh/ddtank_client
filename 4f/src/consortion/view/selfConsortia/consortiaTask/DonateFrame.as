package consortion.view.selfConsortia.consortiaTask
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class DonateFrame extends Frame
   {
       
      
      private var _conentText:FilterFrameText;
      
      private var _ownMoney:FilterFrameText;
      
      private var _taxMedal:TextInput;
      
      private var _confirm:TextButton;
      
      private var _cancel:TextButton;
      
      private var _targetValue:int;
      
      public function DonateFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      private function __addToStageHandler(param1:Event) : void{}
      
      private function __confirmHanlder(param1:MouseEvent) : void{}
      
      private function __cancelHandler(param1:MouseEvent) : void{}
      
      private function __taxChangeHandler(param1:Event) : void{}
      
      private function __enterHanlder(param1:KeyboardEvent) : void{}
      
      public function show() : void{}
      
      public function set targetValue(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
