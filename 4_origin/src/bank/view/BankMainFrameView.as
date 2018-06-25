package bank.view
{
   import bank.BankManager;
   import bank.data.GameBankEvent;
   import bank.view.mornui.bank.BankMainFrameUI;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class BankMainFrameView extends BankMainFrameUI
   {
       
      
      private var _saveOrGetView:BankSaveOrGetView;
      
      public function BankMainFrameView()
      {
         super();
         mainTitle.text = LanguageMgr.GetTranslation("tank.bank.title");
         addEvent();
      }
      
      private function addEvent() : void
      {
         close_btn.addEventListener("click",__closeView);
         saveBtn.addEventListener("click",__saveMoney);
         getBtn.addEventListener("click",__GetMoney);
      }
      
      private function __saveMoney(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
         _saveOrGetView = new BankSaveOrGetView();
         BankManager.instance.dispatchEvent(new GameBankEvent("bank_right_view_change",{"type":1}));
         LayerManager.Instance.addToLayer(_saveOrGetView,3,true,1);
      }
      
      private function __GetMoney(e:MouseEvent) : void
      {
         var msg:* = null;
         SoundManager.instance.play("008");
         if(!BankManager.instance.model.list.length)
         {
            msg = LanguageMgr.GetTranslation("tank.bank.noSaveMoney");
            MessageTipManager.getInstance().show(msg,0,true,1);
         }
         else
         {
            dispose();
            _saveOrGetView = new BankSaveOrGetView();
            BankManager.instance.dispatchEvent(new GameBankEvent("bank_right_view_change",{"type":2}));
            LayerManager.Instance.addToLayer(_saveOrGetView,3,true,1);
            SocketManager.Instance.out.sendBankGetTaskComplete();
         }
      }
      
      private function __closeView(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function removeEvent() : void
      {
         close_btn.removeEventListener("click",__closeView);
         saveBtn.removeEventListener("click",__saveMoney);
         getBtn.removeEventListener("click",__GetMoney);
      }
      
      public function get saveOrGetView() : BankSaveOrGetView
      {
         return _saveOrGetView;
      }
      
      public function set saveOrGetView(value:BankSaveOrGetView) : void
      {
         _saveOrGetView = value;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_saveOrGetView);
         super.dispose();
      }
   }
}
