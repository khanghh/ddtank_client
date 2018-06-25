package dice.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
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
   
   public class DiceSystemPanel extends Sprite implements Disposeable
   {
       
      
      private var _controller:DiceController;
      
      private var _bg:Bitmap;
      
      private var _startBG:Bitmap;
      
      private var _startArrow:Bitmap;
      
      private var _freeCount:FilterFrameText;
      
      private var _startBtn:ScaleFrameImage;
      
      private var _cellItem:Array;
      
      private var _target:int = -1;
      
      private var _baseAlert:BaseAlerFrame;
      
      private var _selectCheckBtn:SelectedCheckButton;
      
      private var _poorManAlert:BaseAlerFrame;
      
      public function DiceSystemPanel()
      {
         super();
         preInitialize();
      }
      
      public function set Controller(value:DiceController) : void
      {
         _controller = value;
         initialize();
         addEvent();
      }
      
      private function initialize() : void
      {
         var i:int = 0;
         addChild(_startBG);
         addChild(_freeCount);
         addChild(_startBtn);
         _startBtn.buttonMode = true;
         _startBtn.setFrame(DiceController.Instance.diceType + 1);
         _freeCount.text = LanguageMgr.GetTranslation("dice.freeCount",DiceController.Instance.freeCount);
         _cellItem = _controller.cellIDs;
         if(!_controller.hasUsedFirstCell)
         {
            if(_startArrow == null)
            {
               _startArrow = ComponentFactory.Instance.creatBitmap("asset.dice.startArrow");
            }
            addChild(_startArrow);
         }
         i = 0;
         while(i < _cellItem.length && i < _controller.CELL_COUNT)
         {
            if(_cellItem[i])
            {
               addChild(_cellItem[i]);
            }
            i++;
         }
      }
      
      private function preInitialize() : void
      {
         _startBG = ComponentFactory.Instance.creatBitmap("asset.dice.bg1");
         _freeCount = ComponentFactory.Instance.creatComponentByStylename("asset.dice.freeCount");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("asset.dice.startBtn");
      }
      
      private function addEvent() : void
      {
         _startBtn.addEventListener("click",__onStartBtnClick);
         DiceController.Instance.addEventListener("dice_player_iswalking",__onPlayerState);
         DiceController.Instance.addEventListener("get_dice_result_data",__getDiceResultData);
         DiceController.Instance.addEventListener("dice_type_changed",__onDicetypeChanged);
         DiceController.Instance.addEventListener("dice_refresh_data",__onRefreshData);
         DiceController.Instance.addEventListener("dice_freeCount_changed",__onFreeCountChanged);
      }
      
      private function removeEvent() : void
      {
         _startBtn.addEventListener("click",__onStartBtnClick);
         DiceController.Instance.removeEventListener("dice_player_iswalking",__onPlayerState);
         DiceController.Instance.removeEventListener("get_dice_result_data",__getDiceResultData);
         DiceController.Instance.removeEventListener("dice_type_changed",__onDicetypeChanged);
         DiceController.Instance.removeEventListener("dice_refresh_data",__onRefreshData);
         DiceController.Instance.removeEventListener("dice_freeCount_changed",__onFreeCountChanged);
      }
      
      private function __onPlayerState(event:DiceEvent) : void
      {
         if(event.resultData.isWalking)
         {
            _startBtn.visible = false;
            DiceController.Instance.setDestinationCell(-1);
         }
         else
         {
            _startBtn.visible = true;
            if(_target != -1)
            {
               DiceController.Instance.setDestinationCell(_target - 1);
            }
         }
      }
      
      private function __getDiceResultData(event:DiceEvent) : void
      {
         var _proxy:Object = event.resultData;
         if(_proxy)
         {
            _target = (int(_proxy.position) + int(_proxy.result)) % DiceController.Instance.CELL_COUNT;
            _target = _target + (_target < int(_proxy.position) && !DiceController.Instance.hasUsedFirstCell?1:0);
         }
         _startBtn.visible = false;
      }
      
      private function __onStartBtnClick(event:MouseEvent) : void
      {
         var price:int = DiceController.Instance.commonDicePrice;
         if(DiceController.Instance.diceType == 1)
         {
            price = DiceController.Instance.doubleDicePrice;
         }
         else if(DiceController.Instance.diceType == 2)
         {
            price = DiceController.Instance.bigDicePrice;
         }
         else if(DiceController.Instance.diceType == 3)
         {
            price = DiceController.Instance.smallDicePrice;
         }
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < Number(price) && DiceController.Instance.freeCount <= 0)
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
      
      private function __poorManResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _poorManAlert.removeEventListener("response",__poorManResponse);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(_poorManAlert);
         _poorManAlert = null;
      }
      
      private function AlertFeedeductionWindow() : void
      {
         if(!DiceController.Instance.canPopupNextStartWindow && DiceController.Instance.freeCount <= 0)
         {
            openAlertFrame();
         }
         else
         {
            _startBtn.visible = false;
            sendStartDataToServer();
         }
      }
      
      private function sendStartDataToServer() : void
      {
         GameInSocketOut.sendStartDiceInfo(DiceController.Instance.diceType,DiceController.Instance.CurrentPosition - 1);
      }
      
      private function openAlertFrame() : void
      {
         var type:* = null;
         var price:int = 0;
         var msg:* = null;
         if(_selectCheckBtn == null)
         {
            _selectCheckBtn = ComponentFactory.Instance.creatComponentByStylename("asset.dice.refreshAlert.selectedCheck");
            _selectCheckBtn.text = LanguageMgr.GetTranslation("dice.alert.nextPrompt");
            _selectCheckBtn.selected = DiceController.Instance.canPopupNextStartWindow;
            _selectCheckBtn.addEventListener("click",__onCheckBtnClick);
         }
         switch(int(DiceController.Instance.diceType) - 1)
         {
            case 0:
               type = LanguageMgr.GetTranslation("dice.type.double");
               price = DiceController.Instance.doubleDicePrice;
               break;
            case 1:
               type = LanguageMgr.GetTranslation("dice.type.big");
               price = DiceController.Instance.bigDicePrice;
               break;
            case 2:
               type = LanguageMgr.GetTranslation("dice.type.small");
               price = DiceController.Instance.smallDicePrice;
         }
         msg = LanguageMgr.GetTranslation("dice.type.prompt",type,price) + "\n\n";
         if(_baseAlert)
         {
            ObjectUtils.disposeObject(_baseAlert);
         }
         _baseAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,2);
         _baseAlert.addChild(_selectCheckBtn);
         _baseAlert.addEventListener("response",__onResponse);
      }
      
      private function __onCheckBtnClick(event:MouseEvent) : void
      {
         var _selectBtn:SelectedCheckButton = event.currentTarget as SelectedCheckButton;
         DiceController.Instance.setPopupNextStartWindow(_selectBtn.selected);
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.target as BaseAlerFrame;
         alert.removeEventListener("response",__onResponse);
         _selectCheckBtn.removeEventListener("click",__onCheckBtnClick);
         ObjectUtils.disposeObject(_selectCheckBtn);
         _selectCheckBtn = null;
         alert.dispose();
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            _startBtn.visible = false;
            sendStartDataToServer();
         }
      }
      
      private function __onDicetypeChanged(event:DiceEvent) : void
      {
         _startBtn.setFrame(DiceController.Instance.diceType + 1);
      }
      
      private function __onFreeCountChanged(event:DiceEvent) : void
      {
         _freeCount.text = LanguageMgr.GetTranslation("dice.freeCount",DiceController.Instance.freeCount);
      }
      
      private function __onRefreshData(event:DiceEvent) : void
      {
         initialize();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_startBG);
         _startBG = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_startArrow);
         _startArrow = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
