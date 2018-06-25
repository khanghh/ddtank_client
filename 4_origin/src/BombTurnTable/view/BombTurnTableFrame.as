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
      
      public function BombTurnTableFrame(control:BombTurnTableControls)
      {
         super();
         _control = control;
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _turnTableView = new TurnTableView(_control);
         if(_turnTableView)
         {
            addToContent(_turnTableView);
         }
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this._container,"ddt.bombTurnTable.helpButton",{
            "x":416,
            "y":93
         },LanguageMgr.GetTranslation("AlertDialog.help"),"asset.bombTurnTable.helpDes",377,380);
      }
      
      public function initEvent() : void
      {
         if(_control != null)
         {
            _control.addEventListener("updateTurntableData",updateView);
         }
      }
      
      private function removeEvent() : void
      {
         if(_control != null)
         {
            _control.removeEventListener("updateTurntableData",updateView);
         }
      }
      
      public function updateView(evt:TurnTableEvent) : void
      {
         if(_turnTableView && _control != null)
         {
            _turnTableView.updateView(evt.data as BombTurnTableInfo);
            _turnTableView.updateLotteryTicket(_control.getLotteryTicket());
         }
      }
      
      public function get turnTableView() : TurnTableView
      {
         return _turnTableView;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_turnTableView)
         {
            ObjectUtils.disposeObject(_turnTableView);
            _turnTableView = null;
         }
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
            _helpBtn = null;
         }
         if(_control)
         {
            _control = null;
         }
         if(this && this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
