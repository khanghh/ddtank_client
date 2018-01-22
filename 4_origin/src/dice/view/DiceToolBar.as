package dice.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import dice.controller.DiceController;
   import dice.event.DiceEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class DiceToolBar extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _currentCouponsCaption:Bitmap;
      
      private var _currentCoupons:FilterFrameText;
      
      private var _currentCouponsBG:Scale9CornerImage;
      
      private var _refreshBtn:BaseButton;
      
      private var _doubleRadio:SelectedButton;
      
      private var _smallRadio:SelectedButton;
      
      private var _bigRadio:SelectedButton;
      
      private var _doubleText:Bitmap;
      
      private var _bigText:Bitmap;
      
      private var _smallText:Bitmap;
      
      private var _baseAlert:BaseAlerFrame;
      
      private var _selectCheckBtn:SelectedCheckButton;
      
      private var _poorManAlert:BaseAlerFrame;
      
      public function DiceToolBar()
      {
         super();
         preInitialize();
         Initialize();
         addEvent();
      }
      
      private function preInitialize() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.dice.toolBar.BG");
         _currentCouponsCaption = ComponentFactory.Instance.creatBitmap("asset.dice.toolBar.currentCouponsCaption");
         _currentCoupons = ComponentFactory.Instance.creatComponentByStylename("asset.dice.toolBar.currentCoupons");
         _currentCouponsBG = ComponentFactory.Instance.creatComponentByStylename("asset.dice.toolBar.currentCoupons.BG");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("asset.dice.toolBar.refreshBtn");
         _refreshBtn.tipData = LanguageMgr.GetTranslation("dice.refresh.tip",DiceController.Instance.refreshPrice);
         ShowTipManager.Instance.addTip(_refreshBtn);
         _doubleRadio = ComponentFactory.Instance.creatComponentByStylename("asset.dice.toolBar.double");
         _doubleRadio.tipData = LanguageMgr.GetTranslation("dice.double.tip",DiceController.Instance.doubleDicePrice);
         ShowTipManager.Instance.addTip(_doubleRadio);
         _smallRadio = ComponentFactory.Instance.creatComponentByStylename("asset.dice.toolBar.small");
         _smallRadio.tipData = LanguageMgr.GetTranslation("dice.small.tip",DiceController.Instance.smallDicePrice);
         ShowTipManager.Instance.addTip(_smallRadio);
         _bigRadio = ComponentFactory.Instance.creatComponentByStylename("asset.dice.toolBar.big");
         _bigRadio.tipData = LanguageMgr.GetTranslation("dice.big.tip",DiceController.Instance.bigDicePrice);
         ShowTipManager.Instance.addTip(_bigRadio);
         _doubleText = ComponentFactory.Instance.creatBitmap("asset.dice.double.text");
         _bigText = ComponentFactory.Instance.creatBitmap("asset.dice.big.text");
         _smallText = ComponentFactory.Instance.creatBitmap("asset.dice.small.text");
      }
      
      private function Initialize() : void
      {
         _currentCoupons.text = String(PlayerManager.Instance.Self.Money);
         addChild(_bg);
         addChild(_currentCouponsBG);
         addChild(_currentCouponsCaption);
         addChild(_currentCoupons);
         addChild(_refreshBtn);
         _doubleRadio.selected = false;
         addChild(_doubleRadio);
         _smallRadio.selected = false;
         addChild(_smallRadio);
         _bigRadio.selected = false;
         addChild(_bigRadio);
         addChild(_doubleText);
         addChild(_bigText);
         addChild(_smallText);
         switch(int(DiceController.Instance.diceType) - 1)
         {
            case 0:
               _doubleRadio.selected = true;
               break;
            case 1:
               _bigRadio.selected = true;
               break;
            case 2:
               _smallRadio.selected = true;
         }
      }
      
      private function addEvent() : void
      {
         _doubleRadio.addEventListener("click",__onSelectBtnClick);
         _smallRadio.addEventListener("click",__onSelectBtnClick);
         _bigRadio.addEventListener("click",__onSelectBtnClick);
         _refreshBtn.addEventListener("click",__onRefreshBtnClick);
         DiceController.Instance.addEventListener("dice_player_iswalking",__onPlayerState);
         DiceController.Instance.addEventListener("get_dice_result_data",__getDiceResultData);
         PlayerManager.Instance.Self.addEventListener("propertychange",__changeMoney);
      }
      
      private function removeEvent() : void
      {
         _doubleRadio.removeEventListener("click",__onSelectBtnClick);
         _smallRadio.removeEventListener("click",__onSelectBtnClick);
         _bigRadio.removeEventListener("click",__onSelectBtnClick);
         _refreshBtn.removeEventListener("click",__onRefreshBtnClick);
         DiceController.Instance.removeEventListener("dice_player_iswalking",__onPlayerState);
         DiceController.Instance.removeEventListener("get_dice_result_data",__getDiceResultData);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__changeMoney);
      }
      
      private function __getDiceResultData(param1:DiceEvent) : void
      {
         _refreshBtn.enable = false;
         _doubleRadio.enable = false;
         _smallRadio.enable = false;
         _bigRadio.enable = false;
      }
      
      private function __onPlayerState(param1:DiceEvent) : void
      {
         if(param1.resultData.isWalking)
         {
            _refreshBtn.enable = false;
            _doubleRadio.enable = false;
            _smallRadio.enable = false;
            _bigRadio.enable = false;
         }
         else
         {
            _refreshBtn.enable = true;
            _doubleRadio.enable = true;
            _smallRadio.enable = true;
            _bigRadio.enable = true;
         }
      }
      
      private function __onRefreshBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < Number(DiceController.Instance.refreshPrice))
         {
            if(_poorManAlert)
            {
               ObjectUtils.disposeObject(_poorManAlert);
            }
            _poorManAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("poorNote"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _poorManAlert.moveEnable = false;
            _poorManAlert.addEventListener("response",__poorManResponse);
            return;
         }
         AlertFeedeductionWindow();
      }
      
      private function __poorManResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _poorManAlert.removeEventListener("response",__poorManResponse);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(_poorManAlert);
         _poorManAlert = null;
      }
      
      private function AlertFeedeductionWindow() : void
      {
         if(!DiceController.Instance.canPopupNextRefreshWindow)
         {
            openAlertFrame();
         }
         else
         {
            sendRefreshDataToServer();
         }
      }
      
      private function sendRefreshDataToServer() : void
      {
         GameInSocketOut.sendDiceRefreshData();
      }
      
      private function openAlertFrame() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("dice.refreshPrompt",DiceController.Instance.refreshPrice) + "\n\n";
         if(_selectCheckBtn == null)
         {
            _selectCheckBtn = ComponentFactory.Instance.creatComponentByStylename("asset.dice.refreshAlert.selectedCheck");
            _selectCheckBtn.text = LanguageMgr.GetTranslation("dice.alert.nextPrompt");
            _selectCheckBtn.selected = DiceController.Instance.canPopupNextRefreshWindow;
            _selectCheckBtn.addEventListener("click",__onCheckBtnClick);
         }
         if(_baseAlert)
         {
            ObjectUtils.disposeObject(_baseAlert);
         }
         _baseAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc1_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,2);
         _baseAlert.addChild(_selectCheckBtn);
         _baseAlert.addEventListener("response",__onResponse);
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onResponse);
         _selectCheckBtn.removeEventListener("click",__onCheckBtnClick);
         ObjectUtils.disposeObject(_selectCheckBtn);
         _selectCheckBtn = null;
         _loc2_.dispose();
         _loc2_ = null;
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            sendRefreshDataToServer();
         }
      }
      
      private function __onCheckBtnClick(param1:MouseEvent) : void
      {
         DiceController.Instance.setPopupNextRefreshWindow(_selectCheckBtn.selected);
      }
      
      private function __changeMoney(param1:PlayerPropertyEvent) : void
      {
         if(_currentCoupons)
         {
            _currentCoupons.text = String(PlayerManager.Instance.Self.Money);
         }
      }
      
      private function __onSelectBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playMusic("062");
         var _loc3_:* = param1.currentTarget;
         if(_doubleRadio !== _loc3_)
         {
            if(_smallRadio !== _loc3_)
            {
               if(_bigRadio === _loc3_)
               {
                  _doubleRadio.selected = false;
                  _smallRadio.selected = false;
               }
            }
            else
            {
               _doubleRadio.selected = false;
               _bigRadio.selected = false;
            }
         }
         else
         {
            _smallRadio.selected = false;
            _bigRadio.selected = false;
         }
         var _loc2_:int = 0;
         if(_doubleRadio.selected)
         {
            _loc2_ = 1;
         }
         else if(_bigRadio.selected)
         {
            _loc2_ = 2;
         }
         else if(_smallRadio.selected)
         {
            _loc2_ = 3;
         }
         DiceController.Instance.diceType = _loc2_;
         DiceController.Instance.dispatchEvent(new DiceEvent("dice_type_changed"));
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_baseAlert);
         _baseAlert = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_currentCouponsCaption);
         _currentCouponsCaption = null;
         ObjectUtils.disposeObject(_currentCouponsBG);
         _currentCouponsBG = null;
         ObjectUtils.disposeObject(_currentCoupons);
         _currentCoupons = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_doubleRadio);
         _doubleRadio = null;
         ObjectUtils.disposeObject(_bigRadio);
         _bigRadio = null;
         ObjectUtils.disposeObject(_smallRadio);
         _smallRadio = null;
         ObjectUtils.disposeObject(_doubleText);
         _doubleText = null;
         ObjectUtils.disposeObject(_bigText);
         _bigText = null;
         ObjectUtils.disposeObject(_smallText);
         _smallText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
