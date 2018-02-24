package magicHouse.magicCollection
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   import magicHouse.MagicHouseModel;
   
   public class MagicHouseChargeBoxCountFrame extends Frame
   {
       
      
      private var _oneTimeBtn:SelectedCheckButton;
      
      private var _fiveTimeBtn:SelectedCheckButton;
      
      private var _okBtn:TextButton;
      
      private var _cancleBtn:TextButton;
      
      private var _tipTxt:FilterFrameText;
      
      public var openCount:int = 1;
      
      public function MagicHouseChargeBoxCountFrame(){super();}
      
      private function initView() : void{}
      
      private function __getBoxChange(param1:MouseEvent) : void{}
      
      private function __confirmGetBox(param1:MouseEvent) : void{}
      
      private function __cancleGetBox(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
