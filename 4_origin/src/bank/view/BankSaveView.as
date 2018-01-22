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
         var _loc1_:int = 0;
         principalTitle.text = LanguageMgr.GetTranslation("tank.bank.title.principal");
         interestTitle.text = LanguageMgr.GetTranslation("tank.bank.title.interest");
         note.text = LanguageMgr.GetTranslation("tank.bank.note");
         money.text = LanguageMgr.GetTranslation("money");
         ddtMoney.text = LanguageMgr.GetTranslation("ddtMoney");
         _data = BankManager.instance.model.data;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            (this["saveItem" + _loc1_] as Label).text = _data[_loc1_ + 1].Name;
            (this["interestRate" + _loc1_] as Label).text = LanguageMgr.GetTranslation("tank.bank.interestRate",Number(_data[_loc1_ + 1].InterestRate / 100));
            (this["Multiple" + _loc1_] as Label).text = LanguageMgr.GetTranslation("tank.bank.saveMultiple",_data[_loc1_ + 1].MinAmount);
            _loc1_++;
         }
         saveInput.textField.restrict = "0-9";
         saveInput.maxChars = 9;
         selectedGrop.selectedIndex = 0;
         saveTips.text = LanguageMgr.GetTranslation("tank.bank.saveTips",_data[selectedGrop.selectedIndex + 1].Multiple);
      }
      
      private function selectedItem(param1:Event) : void
      {
         SoundManager.instance.play("008");
         _index = selectedGrop.selectedIndex;
         saveTips.text = LanguageMgr.GetTranslation("tank.bank.saveTips",_data[_index + 1].Multiple);
         if(parseInt(saveInput.text) > 0)
         {
            calculation(_data[_index + 1].InterestRate);
         }
      }
      
      private function calculation(param1:int) : void
      {
         var _loc2_:int = 0;
         if(saveInput.text == "")
         {
            benjin.text = "0";
            interestRateTxt.text = "0";
         }
         else
         {
            benjin.text = saveInput.text;
            _loc2_ = 0;
            if(_index == 0)
            {
               _loc2_ = param1 * parseInt(saveInput.text) / 10000;
            }
            else
            {
               _loc2_ = param1 * parseInt(saveInput.text) * _data[_index + 1].DeadLine * 30 / 10000;
            }
            interestRateTxt.text = String(_loc2_);
         }
      }
      
      private function textChange(param1:Event) : void
      {
         if(selectedGrop.selectedIndex != -1)
         {
            calculation(_data[_index + 1].InterestRate);
         }
      }
      
      private function saveMoney(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(saveInput.text == "" || parseInt(saveInput.text) == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.bank.noSaveMoneyInput");
            MessageTipManager.getInstance().show(_loc2_,0,true,1);
         }
         else if(parseInt(saveInput.text) < _data[_index + 1].MinAmount)
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.bank.saveMoreMoney",_data[_index + 1].MinAmount);
            MessageTipManager.getInstance().show(_loc2_,0,true,1);
         }
         else if(selectedGrop.selectedIndex == -1)
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.bank.selectedlilv");
            MessageTipManager.getInstance().show(_loc2_,0,true,1);
         }
         else if(parseInt(saveInput.text) % _data[_index + 1].Multiple != 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.bank.saveBeishu",_data[_index + 1].Multiple);
            MessageTipManager.getInstance().show(_loc2_,0,true,1);
         }
         else
         {
            CheckMoneyUtils.instance.checkMoney(false,parseInt(saveInput.text),onChecked,null);
         }
      }
      
      private function onChecked() : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("tank.bank.alert",parseInt(saveInput.text));
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),_loc2_,LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),true,false,false,2);
         _loc1_.addEventListener("response",onResponse);
      }
      
      protected function onResponse(param1:FrameEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         param1.target.removeEventListener("response",onResponse);
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               _loc3_ = selectedGrop.selectedIndex + 1;
               _loc2_ = parseInt(saveInput.text);
               SocketManager.Instance.out.sendBanksaveMoney(_loc3_,_loc2_);
            default:
               _loc3_ = selectedGrop.selectedIndex + 1;
               _loc2_ = parseInt(saveInput.text);
               SocketManager.Instance.out.sendBanksaveMoney(_loc3_,_loc2_);
         }
      }
      
      private function saveViewBack(param1:MouseEvent) : void
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
