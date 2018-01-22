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
      
      public function set Controller(param1:DiceController) : void
      {
         _controller = param1;
         initialize();
         addEvent();
      }
      
      private function initialize() : void
      {
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ < _cellItem.length && _loc1_ < _controller.CELL_COUNT)
         {
            if(_cellItem[_loc1_])
            {
               addChild(_cellItem[_loc1_]);
            }
            _loc1_++;
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
      
      private function __onPlayerState(param1:DiceEvent) : void
      {
         if(param1.resultData.isWalking)
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
      
      private function __getDiceResultData(param1:DiceEvent) : void
      {
         var _loc2_:Object = param1.resultData;
         if(_loc2_)
         {
            _target = (int(_loc2_.position) + int(_loc2_.result)) % DiceController.Instance.CELL_COUNT;
            _target = _target + (_target < int(_loc2_.position) && !DiceController.Instance.hasUsedFirstCell?1:0);
         }
         _startBtn.visible = false;
      }
      
      private function __onStartBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = DiceController.Instance.commonDicePrice;
         if(DiceController.Instance.diceType == 1)
         {
            _loc2_ = DiceController.Instance.doubleDicePrice;
         }
         else if(DiceController.Instance.diceType == 2)
         {
            _loc2_ = DiceController.Instance.bigDicePrice;
         }
         else if(DiceController.Instance.diceType == 3)
         {
            _loc2_ = DiceController.Instance.smallDicePrice;
         }
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < Number(_loc2_) && DiceController.Instance.freeCount <= 0)
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
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc3_:* = null;
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
               _loc2_ = LanguageMgr.GetTranslation("dice.type.double");
               _loc1_ = DiceController.Instance.doubleDicePrice;
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("dice.type.big");
               _loc1_ = DiceController.Instance.bigDicePrice;
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("dice.type.small");
               _loc1_ = DiceController.Instance.smallDicePrice;
         }
         _loc3_ = LanguageMgr.GetTranslation("dice.type.prompt",_loc2_,_loc1_) + "\n\n";
         if(_baseAlert)
         {
            ObjectUtils.disposeObject(_baseAlert);
         }
         _baseAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc3_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,2);
         _baseAlert.addChild(_selectCheckBtn);
         _baseAlert.addEventListener("response",__onResponse);
      }
      
      private function __onCheckBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:SelectedCheckButton = param1.currentTarget as SelectedCheckButton;
         DiceController.Instance.setPopupNextStartWindow(_loc2_.selected);
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
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            _startBtn.visible = false;
            sendStartDataToServer();
         }
      }
      
      private function __onDicetypeChanged(param1:DiceEvent) : void
      {
         _startBtn.setFrame(DiceController.Instance.diceType + 1);
      }
      
      private function __onFreeCountChanged(param1:DiceEvent) : void
      {
         _freeCount.text = LanguageMgr.GetTranslation("dice.freeCount",DiceController.Instance.freeCount);
      }
      
      private function __onRefreshData(param1:DiceEvent) : void
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
