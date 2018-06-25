package bank.view
{
   import baglocked.BaglockedManager;
   import bank.BankManager;
   import bank.data.GameBankEvent;
   import bank.view.mornui.bank.BankSaveUI;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import morn.core.components.Label;
   import road7th.data.DictionaryData;
   
   public class BankSaveView extends BankSaveUI
   {
       
      
      private var _index:int = 0;
      
      private var _data:DictionaryData;
      
      public function BankSaveView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function addEvent() : void
      {
         saveConfirmBtn.addEventListener("click",saveMoney);
         backViewBtn.addEventListener("click",saveViewBack);
         selectedGrop.addEventListener("change",selectedItem);
         saveInput.textField.addEventListener("change",textChange);
      }
      
      private function initView() : void
      {
         var i:int = 0;
         principalTitle.text = LanguageMgr.GetTranslation("tank.bank.title.principal");
         interestTitle.text = LanguageMgr.GetTranslation("tank.bank.title.interest");
         note.text = LanguageMgr.GetTranslation("tank.bank.note");
         money.text = LanguageMgr.GetTranslation("money");
         ddtMoney.text = LanguageMgr.GetTranslation("ddtMoney");
         _data = BankManager.instance.model.data;
         for(i = 0; i < 4; )
         {
            (this["saveItem" + i] as Label).text = _data[i + 1].Name;
            (this["interestRate" + i] as Label).text = LanguageMgr.GetTranslation("tank.bank.interestRate",Number(_data[i + 1].InterestRate / 100));
            (this["Multiple" + i] as Label).text = LanguageMgr.GetTranslation("tank.bank.saveMultiple",_data[i + 1].MinAmount);
            i++;
         }
         saveInput.textField.restrict = "0-9";
         saveInput.maxChars = 9;
         selectedGrop.selectedIndex = 0;
         saveTips.text = LanguageMgr.GetTranslation("tank.bank.saveTips",_data[selectedGrop.selectedIndex + 1].Multiple);
      }
      
      private function selectedItem(e:Event) : void
      {
         SoundManager.instance.play("008");
         _index = selectedGrop.selectedIndex;
         saveTips.text = LanguageMgr.GetTranslation("tank.bank.saveTips",_data[_index + 1].Multiple);
         if(parseInt(saveInput.text) > 0)
         {
            calculation(_data[_index + 1].InterestRate);
         }
      }
      
      private function calculation(value:int) : void
      {
         var profit:int = 0;
         if(saveInput.text == "")
         {
            benjin.text = "0";
            interestRateTxt.text = "0";
         }
         else
         {
            benjin.text = saveInput.text;
            profit = 0;
            if(_index == 0)
            {
               profit = value * parseInt(saveInput.text) / 10000;
            }
            else
            {
               profit = value * parseInt(saveInput.text) * _data[_index + 1].DeadLine * 30 / 10000;
            }
            interestRateTxt.text = String(profit);
         }
      }
      
      private function textChange(e:Event) : void
      {
         if(selectedGrop.selectedIndex != -1)
         {
            calculation(_data[_index + 1].InterestRate);
         }
      }
      
      private function saveMoney(e:MouseEvent) : void
      {
         var msg:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(saveInput.text == "" || parseInt(saveInput.text) == 0)
         {
            msg = LanguageMgr.GetTranslation("tank.bank.noSaveMoneyInput");
            MessageTipManager.getInstance().show(msg,0,true,1);
         }
         else if(parseInt(saveInput.text) < _data[_index + 1].MinAmount)
         {
            msg = LanguageMgr.GetTranslation("tank.bank.saveMoreMoney",_data[_index + 1].MinAmount);
            MessageTipManager.getInstance().show(msg,0,true,1);
         }
         else if(selectedGrop.selectedIndex == -1)
         {
            msg = LanguageMgr.GetTranslation("tank.bank.selectedlilv");
            MessageTipManager.getInstance().show(msg,0,true,1);
         }
         else if(parseInt(saveInput.text) % _data[_index + 1].Multiple != 0)
         {
            msg = LanguageMgr.GetTranslation("tank.bank.saveBeishu",_data[_index + 1].Multiple);
            MessageTipManager.getInstance().show(msg,0,true,1);
         }
         else
         {
            CheckMoneyUtils.instance.checkMoney(false,parseInt(saveInput.text),onChecked,null);
         }
      }
      
      private function onChecked() : void
      {
         var msg:String = LanguageMgr.GetTranslation("tank.bank.alert",parseInt(saveInput.text));
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),msg,LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),true,false,false,2);
         alert.addEventListener("response",onResponse);
      }
      
      protected function onResponse(e:FrameEvent) : void
      {
         var tempId:int = 0;
         var count:int = 0;
         e.target.removeEventListener("response",onResponse);
         SoundManager.instance.play("008");
         switch(int(e.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               tempId = selectedGrop.selectedIndex + 1;
               count = parseInt(saveInput.text);
               SocketManager.Instance.out.sendBanksaveMoney(tempId,count);
            default:
               tempId = selectedGrop.selectedIndex + 1;
               count = parseInt(saveInput.text);
               SocketManager.Instance.out.sendBanksaveMoney(tempId,count);
         }
      }
      
      private function saveViewBack(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         BankManager.instance.dispatchEvent(new GameBankEvent("bank_right_view_back"));
      }
      
      private function removeEvent() : void
      {
         backViewBtn.removeEventListener("click",saveViewBack);
         selectedGrop.removeEventListener("change",selectedItem);
         saveInput.removeEventListener("textInput",textChange);
         saveConfirmBtn.removeEventListener("click",saveMoney);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _data = null;
         super.dispose();
      }
   }
}
