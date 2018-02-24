package BombTurnTable.view
{
   import BombTurnTable.BombTurnTableControls;
   import BombTurnTable.data.BombTurnTableInfo;
   import BombTurnTable.event.TurnTableEvent;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.HelpFrameUtils;
   
   public class BombTurnTableFrame extends Frame
   {
       
      
      private var _turnTableView:TurnTableView;
      
      private var _control:BombTurnTableControls;
      
      private var _helpBtn:BaseButton;
      
      public function BombTurnTableFrame(param1:BombTurnTableControls){super();}
      
      protected function initView() : void{}
      
      public function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function updateView(param1:TurnTableEvent) : void{}
      
      public function get turnTableView() : TurnTableView{return null;}
      
      override public function dispose() : void{}
   }
}
