package escort.view
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
   import escort.EscortControl;
   import escort.EscortManager;
   import escort.data.EscortCarInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class EscortFrameItemCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleTip:FilterFrameText;
      
      private var _awardInfoTxt1:FilterFrameText;
      
      private var _awardInfoTxt2:FilterFrameText;
      
      private var _awardInfoTxt3:FilterFrameText;
      
      private var _escortDefault:FilterFrameText;
      
      private var _escortBtn:TextButton;
      
      private var _index:int;
      
      private var _info:EscortCarInfo;
      
      private var _calledIcon:Bitmap;
      
      public function EscortFrameItemCell(index:int, info:EscortCarInfo)
      {
         super();
         _index = index;
         _info = info;
         initView();
         initEvent();
         refreshView(null);
         if(_escortBtn && EscortControl.instance.freeCount <= 0)
         {
            _escortBtn.enable = false;
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.escort.cellBg" + _index);
         _calledIcon = ComponentFactory.Instance.creatBitmap("asset.escort.hasCalled");
         _calledIcon.visible = false;
         _titleTip = ComponentFactory.Instance.creatComponentByStylename("escort.frame.cellTitleTxt");
         _titleTip.text = LanguageMgr.GetTranslation("escort.frame.cellTitleTxt");
         _awardInfoTxt1 = ComponentFactory.Instance.creatComponentByStylename("escort.frame.cellAwardTxt");
         _awardInfoTxt1.text = LanguageMgr.GetTranslation("escort.frame.cellAwardTxt1") + _info.itemCount;
         _awardInfoTxt2 = ComponentFactory.Instance.creatComponentByStylename("escort.frame.cellAwardTxt");
         PositionUtils.setPos(_awardInfoTxt2,"escort.frame.cellAwardTxt2Pos");
         _awardInfoTxt2.text = LanguageMgr.GetTranslation("escort.frame.cellAwardTxt2",_info.itemCount);
         _awardInfoTxt3 = ComponentFactory.Instance.creatComponentByStylename("escort.frame.cellAwardTxt");
         PositionUtils.setPos(_awardInfoTxt3,"escort.frame.cellAwardTxt3Pos");
         _awardInfoTxt3.text = LanguageMgr.GetTranslation("escort.frame.cellAwardTxt3") + _info.prestige;
         addChild(_bg);
         addChild(_calledIcon);
         addChild(_titleTip);
         addChild(_awardInfoTxt1);
         addChild(_awardInfoTxt3);
         if(_index == 0)
         {
            _escortDefault = ComponentFactory.Instance.creatComponentByStylename("escort.frame.cellTitleTxt");
            PositionUtils.setPos(_escortDefault,"escort.frame.cellEscortTxtPos");
            _escortDefault.text = LanguageMgr.GetTranslation("escort.frame.cellEscortTxt");
            addChild(_escortDefault);
         }
         else
         {
            _escortBtn = ComponentFactory.Instance.creatComponentByStylename("escort.frame.cellCallTxtbtn");
            _escortBtn.text = LanguageMgr.GetTranslation("escort.frame.cellCallTxtbtnTxt");
            addChild(_escortBtn);
         }
      }
      
      private function refreshView(event:Event) : void
      {
         if(EscortControl.instance.carStatus == _index)
         {
            if(_index != 0)
            {
               _escortBtn.text = LanguageMgr.GetTranslation("escort.frame.cellCallTxtbtnTxt2");
               _escortBtn.enable = false;
            }
            _calledIcon.visible = true;
         }
         else
         {
            if(EscortControl.instance.carStatus > _index && _escortBtn)
            {
               _escortBtn.text = LanguageMgr.GetTranslation("escort.frame.cellCallTxtbtnTxt");
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
         EscortManager.instance.addEventListener("escortCarStatusChange",refreshView);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var tmpObj:Object = EscortControl.instance.getBuyRecordStatus(0);
         if(tmpObj.isNoPrompt)
         {
            if(tmpObj.isBand && PlayerManager.Instance.Self.BandMoney < _info.needMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               tmpObj.isNoPrompt = false;
            }
            else if(!tmpObj.isBand && PlayerManager.Instance.Self.Money < _info.needMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("moneyPoorNote"));
               tmpObj.isNoPrompt = false;
            }
            else
            {
               SocketManager.Instance.out.sendEscortCallCar(_index,tmpObj.isBand);
               return;
            }
         }
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("escort.frame.callCarConfirmTxt",_info.needMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"EscortBuyConfirmView",30,true);
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
               confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("escort.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               confirmFrame2.moveEnable = false;
               confirmFrame2.addEventListener("response",callCarReConfirm,false,0,true);
               return;
            }
            if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money < _info.needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((confirmFrame as EscortBuyConfirmView).isNoPrompt)
            {
               tmpObj = EscortControl.instance.getBuyRecordStatus(0);
               tmpObj.isNoPrompt = true;
               tmpObj.isBand = confirmFrame.isBand;
            }
            SocketManager.Instance.out.sendEscortCallCar(_index,confirmFrame.isBand);
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
            SocketManager.Instance.out.sendEscortCallCar(_index,false);
         }
      }
      
      private function removeEvent() : void
      {
         if(_escortBtn)
         {
            _escortBtn.removeEventListener("click",clickHandler);
         }
         EscortManager.instance.removeEventListener("escortCarStatusChange",refreshView);
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
