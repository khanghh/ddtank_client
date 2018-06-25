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
      
      public function set readOnly(value:Boolean) : void
      {
         if(value)
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
         var item:* = null;
         var chip:* = null;
         var pro1:* = null;
         var pro2:* = null;
         var pro3:* = null;
         var pro4:* = null;
         var pro5:* = null;
         var annex:* = _info.getAnnexByIndex(index);
         chargedImg.visible = false;
         if(annex && annex is String)
         {
            this.buttonMode = true;
            _cell.visible = false;
            centerMC.visible = true;
            countTxt.text = "";
            mouseEnabled = true;
            mouseChildren = true;
            if(annex == "gold")
            {
               centerMC.setFrame(3);
               countTxt.text = String(_info.Gold);
               mouseChildren = false;
            }
            else if(annex == "money")
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
            else if(annex == "bindMoney")
            {
               centerMC.setFrame(7);
               countTxt.text = String(_info.BindMoney);
               mouseChildren = false;
            }
            else if(annex == "medal")
            {
               centerMC.setFrame(6);
               countTxt.text = String(_info.Medal);
               mouseChildren = false;
            }
         }
         else if(annex)
         {
            _cell.visible = true;
            item = annex as InventoryItemInfo;
            if(EquipType.isMagicStone(item.CategoryID))
            {
               item.Attack = item.AttackCompose;
               item.Defence = item.DefendCompose;
               item.Agility = item.AgilityCompose;
               item.Luck = item.LuckCompose;
               item.Level = item.StrengthenLevel;
            }
            if(item.CategoryID == 74)
            {
               chip = new MarkChipData();
               chip.templateId = item.TemplateID;
               chip.bornLv = item.StrengthenLevel;
               chip.hammerLv = item.StrengthenExp;
               chip.hLv = item.AttackCompose;
               chip.isbind = item.IsBinds;
               pro1 = new MarkProData();
               pro1.type = item.DefendCompose;
               pro1.value = item.AgilityCompose;
               pro1.attachValue = item.LuckCompose;
               chip.mainPro = pro1;
               pro2 = new MarkProData();
               pro2.type = item.Hole1;
               pro2.value = item.Hole2;
               pro2.attachValue = item.Hole3;
               pro2.hummerCount = item.Hole5Exp;
               chip.props.push(pro2);
               pro3 = new MarkProData();
               pro3.type = item.Hole4;
               pro3.value = item.Hole5;
               pro3.attachValue = item.Hole6;
               pro3.hummerCount = item.Hole6Exp;
               chip.props.push(pro3);
               pro4 = new MarkProData();
               pro4.type = item.ValidDate;
               pro4.value = item.RefineryLevel;
               pro4.attachValue = item.StrengthenTimes;
               pro4.hummerCount = item.Hole5Exp;
               chip.props.push(pro4);
               pro5 = new MarkProData();
               pro5.type = parseInt(item.Skin.split("|")[0]);
               pro5.value = parseInt(item.Skin.split("|")[1]);
               pro5.attachValue = parseInt(item.Skin.split("|")[2]);
               pro5.hummerCount = item.Hole6Level;
               chip.props.push(pro5);
            }
            _cell.info = item;
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
      
      private function __distill(event:MouseEvent) : void
      {
         var i:* = 0;
         SoundManager.instance.play("008");
         if(_info == null)
         {
            return;
         }
         var annex:* = _info.getAnnexByIndex(index);
         if(annex)
         {
            for(i = uint(1); i <= 5; )
            {
               if(annex == _info["Annex" + i])
               {
                  type = i;
                  break;
               }
               i++;
            }
            if(annex == "gold")
            {
               type = 6;
            }
            else if(annex == "money")
            {
               type = 7;
            }
            else if(annex == "bindMoney")
            {
               type = 8;
            }
            else if(annex == "medal")
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
      
      private function __payFrameResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         payAlertFrame.removeEventListener("response",__payFrameResponse);
         payAlertFrame.dispose();
         payAlertFrame = null;
         if(event.responseCode == 3)
         {
            confirmPay();
         }
         else if(event.responseCode == 4 || event.responseCode == 0 || event.responseCode == 1)
         {
            canclePay();
         }
      }
      
      private function confirmPay() : void
      {
         var confirm:* = null;
         if(PlayerManager.Instance.Self.Money >= _info.Money)
         {
            MailControl.Instance.getAnnexToBag(_info,type);
            mouseEnabled = false;
            mouseChildren = false;
         }
         else
         {
            confirm = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            confirm.addEventListener("response",__confirmResponse);
            mouseEnabled = true;
            mouseChildren = true;
         }
      }
      
      private function __confirmResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__confirmResponse);
         ObjectUtils.disposeObject(frame);
         if(frame.parent)
         {
            frame.parent.removeChild(frame);
         }
         if(evt.responseCode == 3 || evt.responseCode == 2)
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
