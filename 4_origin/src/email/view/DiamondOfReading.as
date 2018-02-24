package email.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import email.manager.MailControl;
   import flash.events.MouseEvent;
   import mark.data.MarkChipData;
   import mark.data.MarkProData;
   
   public class DiamondOfReading extends DiamondBase
   {
       
      
      private var type:int;
      
      private var payAlertFrame:BaseAlerFrame;
      
      public function DiamondOfReading()
      {
         super();
      }
      
      public function set readOnly(param1:Boolean) : void
      {
         if(param1)
         {
            removeEvent();
         }
         else
         {
            addEvent();
         }
      }
      
      override protected function addEvent() : void
      {
         addEventListener("click",__distill);
      }
      
      override protected function removeEvent() : void
      {
         removeEventListener("click",__distill);
      }
      
      override protected function update() : void
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = _info.getAnnexByIndex(index);
         chargedImg.visible = false;
         if(_loc7_ && _loc7_ is String)
         {
            this.buttonMode = true;
            _cell.visible = false;
            centerMC.visible = true;
            countTxt.text = "";
            mouseEnabled = true;
            mouseChildren = true;
            if(_loc7_ == "gold")
            {
               centerMC.setFrame(3);
               countTxt.text = String(_info.Gold);
               mouseChildren = false;
            }
            else if(_loc7_ == "money")
            {
               if(_info.Type > 100 || _info.Type == 83 || _info.Type == 81)
               {
                  centerMC.visible = false;
                  mouseEnabled = false;
                  mouseChildren = false;
               }
               else
               {
                  centerMC.setFrame(2);
                  countTxt.text = String(_info.Money);
                  mouseChildren = false;
               }
            }
            else if(_loc7_ == "bindMoney")
            {
               centerMC.setFrame(7);
               countTxt.text = String(_info.BindMoney);
               mouseChildren = false;
            }
            else if(_loc7_ == "medal")
            {
               centerMC.setFrame(6);
               countTxt.text = String(_info.Medal);
               mouseChildren = false;
            }
         }
         else if(_loc7_)
         {
            _cell.visible = true;
            _loc3_ = _loc7_ as InventoryItemInfo;
            if(EquipType.isMagicStone(_loc3_.CategoryID))
            {
               _loc3_.Attack = _loc3_.AttackCompose;
               _loc3_.Defence = _loc3_.DefendCompose;
               _loc3_.Agility = _loc3_.AgilityCompose;
               _loc3_.Luck = _loc3_.LuckCompose;
               _loc3_.Level = _loc3_.StrengthenLevel;
            }
            if(_loc3_.CategoryID == 74)
            {
               _loc1_ = new MarkChipData();
               _loc1_.templateId = _loc3_.TemplateID;
               _loc1_.bornLv = _loc3_.StrengthenLevel;
               _loc1_.hammerLv = _loc3_.StrengthenExp;
               _loc1_.hLv = _loc3_.AttackCompose;
               _loc1_.isbind = _loc3_.IsBinds;
               _loc8_ = new MarkProData();
               _loc8_.type = _loc3_.DefendCompose;
               _loc8_.value = _loc3_.AgilityCompose;
               _loc8_.attachValue = _loc3_.LuckCompose;
               _loc1_.mainPro = _loc8_;
               _loc6_ = new MarkProData();
               _loc6_.type = _loc3_.Hole1;
               _loc6_.value = _loc3_.Hole2;
               _loc6_.attachValue = _loc3_.Hole3;
               _loc6_.hummerCount = _loc3_.Hole5Exp;
               _loc1_.props.push(_loc6_);
               _loc5_ = new MarkProData();
               _loc5_.type = _loc3_.Hole4;
               _loc5_.value = _loc3_.Hole5;
               _loc5_.attachValue = _loc3_.Hole6;
               _loc5_.hummerCount = _loc3_.Hole6Exp;
               _loc1_.props.push(_loc5_);
               _loc4_ = new MarkProData();
               _loc4_.type = _loc3_.ValidDate;
               _loc4_.value = _loc3_.RefineryLevel;
               _loc4_.attachValue = _loc3_.StrengthenTimes;
               _loc4_.hummerCount = _loc3_.Hole5Exp;
               _loc1_.props.push(_loc4_);
               _loc2_ = new MarkProData();
               _loc2_.type = parseInt(_loc3_.Skin.split("|")[0]);
               _loc2_.value = parseInt(_loc3_.Skin.split("|")[1]);
               _loc2_.attachValue = parseInt(_loc3_.Skin.split("|")[2]);
               _loc2_.hummerCount = _loc3_.Hole6Level;
               _loc1_.props.push(_loc2_);
            }
            _cell.info = _loc3_;
            mouseEnabled = true;
            mouseChildren = true;
            countTxt.text = "";
            if(_info.Type > 100 && _info.Money > 0)
            {
               centerMC.visible = false;
               chargedImg.visible = true;
            }
            else
            {
               centerMC.visible = false;
            }
         }
         else
         {
            mouseEnabled = false;
            mouseChildren = false;
            centerMC.visible = false;
            _cell.visible = false;
            countTxt.text = "";
         }
      }
      
      private function __distill(param1:MouseEvent) : void
      {
         var _loc3_:* = 0;
         SoundManager.instance.play("008");
         if(_info == null)
         {
            return;
         }
         var _loc2_:* = _info.getAnnexByIndex(index);
         if(_loc2_)
         {
            _loc3_ = uint(1);
            while(_loc3_ <= 5)
            {
               if(_loc2_ == _info["Annex" + _loc3_])
               {
                  type = _loc3_;
                  break;
               }
               _loc3_++;
            }
            if(_loc2_ == "gold")
            {
               type = 6;
            }
            else if(_loc2_ == "money")
            {
               type = 7;
            }
            else if(_loc2_ == "bindMoney")
            {
               type = 8;
            }
            else if(_loc2_ == "medal")
            {
               type = 9;
            }
         }
         if(PlayerManager.Instance.Self.bagLocked && type != 94)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(type > -1)
         {
            if(_info.Type > 100 && (type >= 1 && type <= 5) && _info.Money > 0)
            {
               payAlertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.view.emailII.EmailIIDiamondView.emailTip"),LanguageMgr.GetTranslation("tank.view.emailII.EmailIIDiamondView.deleteTip") + " " + _info.Money + LanguageMgr.GetTranslation("tank.view.emailII.EmailIIDiamondView.money"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               payAlertFrame.addEventListener("response",__payFrameResponse);
               return;
            }
            MailControl.Instance.getAnnexToBag(_info,type);
         }
      }
      
      private function __payFrameResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         payAlertFrame.removeEventListener("response",__payFrameResponse);
         payAlertFrame.dispose();
         payAlertFrame = null;
         if(param1.responseCode == 3)
         {
            confirmPay();
         }
         else if(param1.responseCode == 4 || param1.responseCode == 0 || param1.responseCode == 1)
         {
            canclePay();
         }
      }
      
      private function confirmPay() : void
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Money >= _info.Money)
         {
            MailControl.Instance.getAnnexToBag(_info,type);
            mouseEnabled = false;
            mouseChildren = false;
         }
         else
         {
            _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _loc1_.addEventListener("response",__confirmResponse);
            mouseEnabled = true;
            mouseChildren = true;
         }
      }
      
      private function __confirmResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__confirmResponse);
         ObjectUtils.disposeObject(_loc2_);
         if(_loc2_.parent)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
      
      private function canclePay() : void
      {
         mouseEnabled = true;
         mouseChildren = true;
      }
      
      override public function dispose() : void
      {
         if(payAlertFrame)
         {
            payAlertFrame.removeEventListener("response",__payFrameResponse);
            payAlertFrame.dispose();
         }
         payAlertFrame = null;
         super.dispose();
      }
   }
}
