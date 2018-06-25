package sevenDouble.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import sevenDouble.SevenDoubleControl;
   import sevenDouble.SevenDoubleManager;
   import sevenDouble.data.SevenDoubleCarInfo;
   
   public class SevenDoubleFrameItemCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleTip:FilterFrameText;
      
      private var _awardInfoTxt1:FilterFrameText;
      
      private var _awardInfoTxt2:FilterFrameText;
      
      private var _awardInfoTxt3:FilterFrameText;
      
      private var _escortDefault:FilterFrameText;
      
      private var _escortBtn:TextButton;
      
      private var _index:int;
      
      private var _info:SevenDoubleCarInfo;
      
      private var _calledIcon:Bitmap;
      
      public function SevenDoubleFrameItemCell(index:int, info:SevenDoubleCarInfo)
      {
         super();
         _index = index;
         _info = info;
         initView();
         initEvent();
         refreshView(null);
         if(_escortBtn && SevenDoubleControl.instance.freeCount <= 0 && SevenDoubleControl.instance.usableCount <= 0)
         {
            _escortBtn.enable = false;
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.sevenDouble.cellBg" + _index);
         _calledIcon = ComponentFactory.Instance.creatBitmap("asset.sevenDouble.hasCalled");
         _calledIcon.visible = false;
         _titleTip = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.cellTitleTxt");
         _titleTip.text = LanguageMgr.GetTranslation("sevenDouble.frame.cellTitleTxt");
         _awardInfoTxt1 = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.cellAwardTxt");
         _awardInfoTxt1.text = LanguageMgr.GetTranslation("sevenDouble.frame.cellAwardTxt1") + _info.prestige;
         _awardInfoTxt2 = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.cellAwardTxt");
         PositionUtils.setPos(_awardInfoTxt2,"sevenDouble.frame.cellAwardTxt2Pos");
         _awardInfoTxt2.text = LanguageMgr.GetTranslation("sevenDouble.frame.cellAwardTxt2",_info.itemCount);
         _awardInfoTxt3 = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.cellAwardTxt");
         PositionUtils.setPos(_awardInfoTxt3,"sevenDouble.frame.cellAwardTxt3Pos");
         _awardInfoTxt3.text = LanguageMgr.GetTranslation("sevenDouble.frame.cellAwardTxt3",_info.speed);
         addChild(_bg);
         addChild(_calledIcon);
         addChild(_titleTip);
         addChild(_awardInfoTxt1);
         addChild(_awardInfoTxt2);
         addChild(_awardInfoTxt3);
         if(_index == 0)
         {
            _escortDefault = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.cellTitleTxt");
            PositionUtils.setPos(_escortDefault,"sevenDouble.frame.cellEscortTxtPos");
            _escortDefault.text = LanguageMgr.GetTranslation("sevenDouble.frame.cellEscortTxt");
            addChild(_escortDefault);
         }
         else
         {
            _escortBtn = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.cellCallTxtbtn");
            _escortBtn.text = LanguageMgr.GetTranslation("sevenDouble.frame.cellCallTxtbtnTxt");
            addChild(_escortBtn);
         }
      }
      
      private function refreshView(event:Event) : void
      {
         if(SevenDoubleControl.instance.carStatus == _index)
         {
            if(_index != 0)
            {
               _escortBtn.text = LanguageMgr.GetTranslation("sevenDouble.frame.cellCallTxtbtnTxt2");
               _escortBtn.x = 35;
               _escortBtn.enable = false;
            }
            _calledIcon.visible = true;
         }
         else
         {
            if(SevenDoubleControl.instance.carStatus > _index && _escortBtn)
            {
               _escortBtn.text = LanguageMgr.GetTranslation("sevenDouble.frame.cellCallTxtbtnTxt");
               _escortBtn.x = 45;
               _escortBtn.enable = false;
            }
            _calledIcon.visible = false;
         }
      }
      
      private function initEvent() : void
      {
         if(_escortBtn)
         {
            _escortBtn.addEventListener("click",clickHandler,false,0,true);
         }
         SevenDoubleManager.instance.addEventListener("sevenDoubleCarStatusChange",refreshView);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var tmpObj:Object = SevenDoubleControl.instance.getBuyRecordStatus(0);
         if(tmpObj.isNoPrompt)
         {
            if(tmpObj.isBand && PlayerManager.Instance.Self.BandMoney < _info.needMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               tmpObj.isNoPrompt = false;
            }
            else if(PlayerManager.Instance.Self.Money < _info.needMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("moneyPoorNote"));
               tmpObj.isNoPrompt = false;
            }
            else
            {
               SocketManager.Instance.out.sendSevenDoubleCallCar(_index,tmpObj.isBand);
               return;
            }
         }
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.frame.callCarConfirmTxt",_info.needMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SevenDoubleBuyConfirmView",30,true,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",callConfirm,false,0,true);
      }
      
      private function callConfirm(evt:FrameEvent) : void
      {
         var confirmFrame2:* = null;
         var tmpObj:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",callConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            if(confirmFrame.isBand && PlayerManager.Instance.Self.BandMoney < _info.needMoney)
            {
               confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               confirmFrame2.moveEnable = false;
               confirmFrame2.addEventListener("response",callCarReConfirm,false,0,true);
               return;
            }
            if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money < _info.needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((confirmFrame as SevenDoubleBuyConfirmView).isNoPrompt)
            {
               tmpObj = SevenDoubleControl.instance.getBuyRecordStatus(0);
               tmpObj.isNoPrompt = true;
               tmpObj.isBand = confirmFrame.isBand;
            }
            SocketManager.Instance.out.sendSevenDoubleCallCar(_index,confirmFrame.isBand);
         }
      }
      
      private function callCarReConfirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",callCarReConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.Money < _info.needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendSevenDoubleCallCar(_index,false);
         }
      }
      
      private function removeEvent() : void
      {
         if(_escortBtn)
         {
            _escortBtn.removeEventListener("click",clickHandler);
         }
         SevenDoubleManager.instance.removeEventListener("sevenDoubleCarStatusChange",refreshView);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _titleTip = null;
         _awardInfoTxt1 = null;
         _awardInfoTxt2 = null;
         _awardInfoTxt3 = null;
         _escortDefault = null;
         _escortBtn = null;
         _info = null;
         _calledIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
