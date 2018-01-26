package cityBattle.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   
   public class ContentionInspireFrame extends Frame
   {
       
      
      private var _inspireInfo:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _itemGroup:SelectedButtonGroup;
      
      private var _submitButton:TextButton;
      
      private var _moneyArray:Array;
      
      private var discount1:FilterFrameText;
      
      private var discount2:FilterFrameText;
      
      private var discount3:FilterFrameText;
      
      public function ContentionInspireFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      protected function _responseHandle(param1:FrameEvent) : void{}
      
      private function __buy(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
