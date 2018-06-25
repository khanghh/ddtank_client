package bank.view
{
   import bank.BankManager;
   import bank.data.BankRecordInfo;
   import bank.data.GameBankEvent;
   import bank.view.mornui.bank.BankSaveRecordItemUI;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class BankSaveRecordView extends BankSaveRecordItemUI
   {
       
      
      private var lineBoolean:Boolean;
      
      private var _btnSprite:Sprite;
      
      private var _info:BankRecordInfo;
      
      private var _index:int;
      
      public function BankSaveRecordView(index:int)
      {
         super();
         _index = index;
         _btnSprite = new Sprite();
         _btnSprite.graphics.beginFill(16777215,0);
         _btnSprite.graphics.drawRect(22,115,267,78);
         _btnSprite.graphics.endFill();
         addChild(_btnSprite);
         _btnSprite.buttonMode = true;
         _btnSprite.x = 121;
         _btnSprite.y = 19;
         _btnSprite.addEventListener("click",changeView);
      }
      
      public function setInfo(info:BankRecordInfo) : void
      {
         var data:DictionaryData = BankManager.instance.model.data;
         if(data[info.tempId].DeadLine == 0)
         {
            saveTypeImg.skin = "asset.bank.checking";
            timeNum.text = LanguageMgr.GetTranslation("tank.bank.checkingAccount",Number(data[info.tempId].InterestRate / 100));
            overTimeImg.skin = "";
         }
         else
         {
            saveTypeImg.skin = "asset.bank.regular";
            timeNum.text = LanguageMgr.GetTranslation("tank.bank.regular",data[info.tempId].DeadLine,Number(data[info.tempId].InterestRate / 100));
            if(BankManager.instance.isAchieve(info))
            {
               overTimeImg.skin = "asset.bank.complete";
            }
            else
            {
               overTimeImg.skin = "asset.bank.notComplete";
            }
         }
         startTimeTxt.text = getTime(info.begainTime);
         moneyNum.text = LanguageMgr.GetTranslation("tank.bank.moneyNum",info.Amount);
         profitNum.text = LanguageMgr.GetTranslation("tank.bank.Interest",BankManager.instance.getProfitNum(info,true));
      }
      
      private function getTime(data:Date) : String
      {
         return data.fullYear + "-" + (data.month + 1) + "-" + data.date;
      }
      
      private function changeView(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         BankManager.instance.dispatchEvent(new GameBankEvent("bank_left_view_line_show",{"index":_index}));
         BankManager.instance.dispatchEvent(new GameBankEvent("bank_left_item_click",{"isPageBtn":false}));
      }
      
      override public function dispose() : void
      {
         _btnSprite.removeEventListener("click",changeView);
         ObjectUtils.disposeObject(_btnSprite);
         _btnSprite = null;
         super.dispose();
      }
   }
}
