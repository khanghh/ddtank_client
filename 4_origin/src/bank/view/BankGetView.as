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
      
      private function textChange(param1:Event) : void
      {
         var _loc2_:BankRecordInfo = BankManager.instance.model.list[(_currentPage - 1) * 3 + _index];
         if(parseInt(getInput.text) > _loc2_.Amount)
         {
            getInput.text = String(_loc2_.Amount);
         }
      }
      
      private function canGetMoney(param1:MouseEvent) : void
      {
         var _loc5_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = null;
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
         var _loc7_:BankRecordInfo = BankManager.instance.model.list[(_currentPage - 1) * 3 + _index];
         _info = _loc7_;
         var _loc6_:int = _loc7_.bankId;
         var _loc4_:DictionaryData = BankManager.instance.model.data;
         if(getInput.text == "" || parseInt(getInput.text) == 0)
         {
            _loc5_ = LanguageMgr.GetTranslation("tank.bank.noGetMoney");
            MessageTipManager.getInstance().show(_loc5_,0,true,1);
         }
         else if(parseInt(getInput.text) > _loc7_.Amount)
         {
            _loc5_ = LanguageMgr.GetTranslation("tank.bank.getMoneyAlert",_loc4_[_loc7_.tempId].MinAmount);
            MessageTipManager.getInstance().show(_loc5_,0,true,1);
         }
         else if(parseInt(getInput.text) % _loc4_[_loc7_.tempId].Multiple != 0)
         {
            _loc5_ = LanguageMgr.GetTranslation("tank.bank.getBeishu",_loc4_[_loc7_.tempId].Multiple);
            MessageTipManager.getInstance().show(_loc5_,0,true,1);
         }
         else
         {
            _loc2_ = 0;
            if(BankManager.instance.isAchieve(_loc7_))
            {
               _loc2_ = BankManager.instance.getProfitNum(_loc7_,false,parseInt(getInput.text));
            }
            else
            {
               _loc2_ = BankManager.instance.getProfitNum(_loc7_,false,parseInt(getInput.text),false) * (100 - BankManager.instance.model.data[_loc7_.tempId].Consume) / 100;
            }
            _loc5_ = LanguageMgr.GetTranslation("tank.bank.getalert",parseInt(getInput.text),_loc2_);
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),_loc5_,LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),true,false,false,2);
            _loc3_.addEventListener("response",onResponse);
         }
      }
      
      protected function onResponse(param1:FrameEvent) : void
      {
         param1.target.removeEventListener("response",onResponse);
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
      
      private function getMoney(param1:int) : void
      {
         var _loc2_:int = parseInt(getInput.text);
         SocketManager.Instance.out.sendBankGetMoney(param1,_loc2_);
      }
      
      public function setInfo(param1:int, param2:int) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         _currentPage = param1;
         _index = param2 == -1?0:param2;
         var _loc7_:BankRecordInfo = BankManager.instance.model.list[(_currentPage - 1) * 3 + _index];
         moneyNum.text = String(_loc7_.Amount) + " " + LanguageMgr.GetTranslation("createConsortionFrame.ticketText.Text2");
         var _loc6_:DictionaryData = BankManager.instance.model.data;
         if(_loc6_[_loc7_.tempId].DeadLine == 0)
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
            saveType.text = LanguageMgr.GetTranslation("tank.bank.dingqiAccount") + LanguageMgr.GetTranslation("tank.bank.monthNum",_loc6_[_loc7_.tempId].DeadLine);
            _loc5_ = TimeManager.Instance.Now().time;
            _loc4_ = _loc7_.begainTime.time;
            _loc3_ = _loc6_[_loc7_.tempId].DeadLine * 30 * 24 * 60 * 60 * 1000;
            _loc4_ = _loc4_ + _loc3_ - _loc5_;
            if(_loc4_ <= 0)
            {
               leftTime.text = LanguageMgr.GetTranslation("tank.bank.arriveGetTime");
            }
            else
            {
               _loc4_ = _loc4_ / 1000 / 60 / 60 / 24;
               leftTime.text = _loc4_ >= 1?LanguageMgr.GetTranslation("tank.bank.leftManyTime",int(_loc4_)):LanguageMgr.GetTranslation("tank.bank.leftLittleTime");
            }
         }
         InterestRate.text = LanguageMgr.GetTranslation("tank.bank.interestRate",Number(_loc6_[_loc7_.tempId].InterestRate / 100));
         myMoney.text = String(_loc7_.Amount);
         profitMoney.text = String(BankManager.instance.getProfitNum(_loc7_,true));
      }
      
      private function getViewBack(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         BankManager.instance.dispatchEvent(new GameBankEvent("bank_right_view_back"));
      }
      
      private function goSave(param1:MouseEvent) : void
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
