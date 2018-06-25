package bank.view
{
   import baglocked.BaglockedManager;
   import bank.BankManager;
   import bank.data.BankRecordInfo;
   import bank.data.GameBankEvent;
   import bank.view.mornui.bank.BankGetUI;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import road7th.data.DictionaryData;
   
   public class BankGetView extends BankGetUI
   {
       
      
      private var _currentPage:int;
      
      private var _index:int;
      
      private var _info:BankRecordInfo;
      
      private var _clickTime:Number = 0;
      
      public function BankGetView()
      {
         super();
         principalTitle.text = LanguageMgr.GetTranslation("tank.bank.title.principal");
         interestTitle.text = LanguageMgr.GetTranslation("tank.bank.title.interest");
         note.text = LanguageMgr.GetTranslation("tank.bank.note");
         money.text = LanguageMgr.GetTranslation("money");
         money1.text = LanguageMgr.GetTranslation("money");
         ddtMoney.text = LanguageMgr.GetTranslation("ddtMoney");
         addEvent();
         getInput.textField.restrict = "0-9";
         getInput.maxChars = 9;
      }
      
      private function addEvent() : void
      {
         getInput.textField.addEventListener("change",textChange);
         backViewBtn.addEventListener("click",getViewBack);
         goSaveBtn.addEventListener("click",goSave);
         getBtn.addEventListener("click",canGetMoney);
      }
      
      private function textChange(e:Event) : void
      {
         var info:BankRecordInfo = BankManager.instance.model.list[(_currentPage - 1) * 3 + _index];
         if(parseInt(getInput.text) > info.Amount)
         {
            getInput.text = String(info.Amount);
         }
      }
      
      private function canGetMoney(e:MouseEvent) : void
      {
         var msg:* = null;
         var profit:int = 0;
         var alert:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(getTimer() - _clickTime < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return;
         }
         _clickTime = getTimer();
         var info:BankRecordInfo = BankManager.instance.model.list[(_currentPage - 1) * 3 + _index];
         _info = info;
         var bankId:int = info.bankId;
         var data:DictionaryData = BankManager.instance.model.data;
         if(getInput.text == "" || parseInt(getInput.text) == 0)
         {
            msg = LanguageMgr.GetTranslation("tank.bank.noGetMoney");
            MessageTipManager.getInstance().show(msg,0,true,1);
         }
         else if(parseInt(getInput.text) > info.Amount)
         {
            msg = LanguageMgr.GetTranslation("tank.bank.getMoneyAlert",data[info.tempId].MinAmount);
            MessageTipManager.getInstance().show(msg,0,true,1);
         }
         else if(parseInt(getInput.text) % data[info.tempId].Multiple != 0)
         {
            msg = LanguageMgr.GetTranslation("tank.bank.getBeishu",data[info.tempId].Multiple);
            MessageTipManager.getInstance().show(msg,0,true,1);
         }
         else
         {
            profit = 0;
            if(BankManager.instance.isAchieve(info))
            {
               profit = BankManager.instance.getProfitNum(info,false,parseInt(getInput.text));
            }
            else
            {
               profit = BankManager.instance.getProfitNum(info,false,parseInt(getInput.text),false) * (100 - BankManager.instance.model.data[info.tempId].Consume) / 100;
            }
            msg = LanguageMgr.GetTranslation("tank.bank.getalert",parseInt(getInput.text),profit);
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),msg,LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),true,false,false,2);
            alert.addEventListener("response",onResponse);
         }
      }
      
      protected function onResponse(e:FrameEvent) : void
      {
         e.target.removeEventListener("response",onResponse);
         SoundManager.instance.play("008");
         switch(int(e.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               getMoney(_info.bankId);
            default:
               getMoney(_info.bankId);
         }
      }
      
      private function getMoney(bankId:int) : void
      {
         var Count:int = parseInt(getInput.text);
         SocketManager.Instance.out.sendBankGetMoney(bankId,Count);
      }
      
      public function setInfo(currentPage:int, index:int) : void
      {
         var now:Number = NaN;
         var leftTimeNum:Number = NaN;
         var time:Number = NaN;
         _currentPage = currentPage;
         _index = index == -1?0:index;
         var data:BankRecordInfo = BankManager.instance.model.list[(_currentPage - 1) * 3 + _index];
         moneyNum.text = String(data.Amount) + " " + LanguageMgr.GetTranslation("createConsortionFrame.ticketText.Text2");
         var modelData:DictionaryData = BankManager.instance.model.data;
         if(modelData[data.tempId].DeadLine == 0)
         {
            getTypeImg.skin = "asset.bank.checking";
            saveType.text = LanguageMgr.GetTranslation("tank.bank.checkingAccountGet");
            leftTime.text = LanguageMgr.GetTranslation("tank.bank.getAnyTime");
            getTip.text = LanguageMgr.GetTranslation("tank.bank.aliveTip");
         }
         else
         {
            getTypeImg.skin = "asset.bank.regular";
            getTip.text = LanguageMgr.GetTranslation("tank.bank.deadTip");
            saveType.text = LanguageMgr.GetTranslation("tank.bank.dingqiAccount") + LanguageMgr.GetTranslation("tank.bank.monthNum",modelData[data.tempId].DeadLine);
            now = TimeManager.Instance.Now().time;
            leftTimeNum = data.begainTime.time;
            time = modelData[data.tempId].DeadLine * 30 * 24 * 60 * 60 * 1000;
            leftTimeNum = leftTimeNum + time - now;
            if(leftTimeNum <= 0)
            {
               leftTime.text = LanguageMgr.GetTranslation("tank.bank.arriveGetTime");
            }
            else
            {
               leftTimeNum = leftTimeNum / 1000 / 60 / 60 / 24;
               leftTime.text = leftTimeNum >= 1?LanguageMgr.GetTranslation("tank.bank.leftManyTime",int(leftTimeNum)):LanguageMgr.GetTranslation("tank.bank.leftLittleTime");
            }
         }
         InterestRate.text = LanguageMgr.GetTranslation("tank.bank.interestRate",Number(modelData[data.tempId].InterestRate / 100));
         myMoney.text = String(data.Amount);
         profitMoney.text = String(BankManager.instance.getProfitNum(data,true));
      }
      
      private function getViewBack(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         BankManager.instance.dispatchEvent(new GameBankEvent("bank_right_view_back"));
      }
      
      private function goSave(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         BankManager.instance.dispatchEvent(new GameBankEvent("bank_right_view_change",{
            "type":1,
            "lastType":2
         }));
      }
      
      private function removeEvent() : void
      {
         backViewBtn.removeEventListener("click",getViewBack);
         getInput.textField.removeEventListener("change",textChange);
         goSaveBtn.removeEventListener("click",goSave);
         getBtn.removeEventListener("click",canGetMoney);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}
