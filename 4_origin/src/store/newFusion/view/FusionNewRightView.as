package store.newFusion.view
{
   import bagAndInfo.bag.RichesButton;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import store.newFusion.FusionNewManager;
   import store.newFusion.data.FusionNewVo;
   
   public class FusionNewRightView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _fusionBg:Bitmap;
      
      private var _successBg:Bitmap;
      
      private var _fusionCell:BagCell;
      
      private var _materialList:Vector.<FusionNewMaterialCell>;
      
      private var _data:FusionNewVo;
      
      private var _successTipTxt:FilterFrameText;
      
      private var _successRateTxt:FilterFrameText;
      
      private var _needMoneyTipTxt:FilterFrameText;
      
      private var _needMoneyNumTxt:FilterFrameText;
      
      private var _moneyIcon:Bitmap;
      
      private var _fusionBtn:SimpleBitmapButton;
      
      private var _stopBtn:SimpleBitmapButton;
      
      private var _inputNumBg:Bitmap;
      
      private var _inputNumTxt:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _maxNum:int;
      
      private var _inCount:int = 0;
      
      private var _isInFusion:Boolean = false;
      
      private var _coverSprite:Sprite;
      
      private var _previewTxt:FilterFrameText;
      
      private var _fusionNameTxt:FilterFrameText;
      
      private var _fusionNum:int;
      
      private var _fusionAttribute:SelectedCheckButton;
      
      private var _clickTime:Number = 0;
      
      private var showMoneyBG:MutipleImage;
      
      private var goldTxt:FilterFrameText;
      
      private var _moneyButton:RichesButton;
      
      public function FusionNewRightView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.newFusion.rightViewBg");
         _fusionBg = ComponentFactory.Instance.creatBitmap("asset.ddtstore.EquipmentCellBg");
         PositionUtils.setPos(_fusionBg,"store.newFusion.rightView.fusionBgPos");
         _successBg = ComponentFactory.Instance.creatBitmap("asset.newFusion.successBg");
         addChild(_bg);
         addChild(_fusionBg);
         addChild(_successBg);
         _inputNumBg = ComponentFactory.Instance.creatBitmap("asset.newFusion.inputBg");
         _inputNumTxt = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.inputTxt");
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.maxBtn");
         addChild(_inputNumBg);
         addChild(_inputNumTxt);
         addChild(_maxBtn);
         _successTipTxt = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.rightView.successTipTxt");
         _successTipTxt.text = LanguageMgr.GetTranslation("ddt.store.newFusion.rightView.successTipTxt");
         _successRateTxt = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.rightView.successRateTxt");
         _needMoneyTipTxt = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.rightView.successTipTxt");
         PositionUtils.setPos(_needMoneyTipTxt,"store.newFusion.rightView.needMoneyTipTxtPos");
         _needMoneyTipTxt.text = LanguageMgr.GetTranslation("ddt.store.newFusion.rightView.needMoneyTipTxt");
         _needMoneyNumTxt = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.rightView.needMoneyNumTxt");
         _needMoneyNumTxt.text = "1600";
         _moneyIcon = ComponentFactory.Instance.creatBitmap("asset.ddtcore.Gold");
         PositionUtils.setPos(_moneyIcon,"store.newFusion.rightView.moneyIconPos");
         addChild(_successTipTxt);
         addChild(_successRateTxt);
         addChild(_needMoneyTipTxt);
         addChild(_needMoneyNumTxt);
         addChild(_moneyIcon);
         _fusionBtn = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.fusionBtn");
         addChild(_fusionBtn);
         _coverSprite = new Sprite();
         _coverSprite.x = -1000;
         _coverSprite.y = -600;
         _coverSprite.graphics.beginFill(0,0);
         _coverSprite.graphics.drawRect(0,0,2000,1200);
         _coverSprite.graphics.endFill();
         addChild(_coverSprite);
         _coverSprite.visible = false;
         _stopBtn = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.stopBtn");
         addChild(_stopBtn);
         _stopBtn.visible = false;
         _fusionCell = new BagCell(1,null,true,null,false);
         _fusionCell.x = _fusionBg.x + 30;
         _fusionCell.y = _fusionBg.y + 33;
         _fusionCell.setBgVisible(false);
         addChild(_fusionCell);
         _materialList = new Vector.<FusionNewMaterialCell>();
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc3_ = new FusionNewMaterialCell(_loc4_ + 1);
            _loc3_.x = 213 + _loc4_ % 2 * (30 + _loc3_.width);
            _loc3_.y = 53 + int(_loc4_ / 2) * (30 + _loc3_.height);
            addChild(_loc3_);
            _materialList.push(_loc3_);
            _loc4_++;
         }
         _previewTxt = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.rightView.previewTxt");
         _previewTxt.text = LanguageMgr.GetTranslation("store.view.fusion.PreviewFrame.preview");
         addChild(_previewTxt);
         _fusionNameTxt = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.rightView.fusionNameTxt");
         addChild(_fusionNameTxt);
         _fusionAttribute = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.rightView.fusionAttribute");
         _fusionAttribute.text = LanguageMgr.GetTranslation("store.view.fusion.PreviewFrame.fusionAttribute");
         addChild(_fusionAttribute);
         _fusionAttribute.visible = false;
         _fusionAttribute.selected = true;
         var _loc2_:Scale9CornerImage = ComponentFactory.Instance.creat("core.Scale9CornerImage.Scale9CornerImage20");
         addChild(_loc2_);
         PositionUtils.setPos(_loc2_,"ddtstore.FineStore.GoldBGPos");
         var _loc1_:MutipleImage = ComponentFactory.Instance.creat("ddtstore.StoreBagView.MoneyTextBg");
         PositionUtils.setPos(_loc1_,"ddtstore.FineStore.GoldBGPos");
         addChild(_loc1_);
         _moneyButton = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagView.MoneyButton");
         _moneyButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.MoneyDirections");
         PositionUtils.setPos(_moneyButton,"ddtstore.FineStore.GoldPos");
         addChild(_moneyButton);
         goldTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.GoldText");
         goldTxt.autoSize = "left";
         PositionUtils.setPos(goldTxt,"ddtstore.FineStore.GoldPos");
         addChild(goldTxt);
         updateMoney();
      }
      
      private function initEvent() : void
      {
         _fusionBtn.addEventListener("click",fusionHandler,false,0,true);
         _stopBtn.addEventListener("click",stopHandler,false,0,true);
         _maxBtn.addEventListener("click",changeMaxHandler,false,0,true);
         _inputNumTxt.addEventListener("change",inputTextChangeHandler,false,0,true);
         SocketManager.Instance.addEventListener(PkgEvent.format(78),fusionCompleteHandler);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
      }
      
      public function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Money"] || param1.changedProperties["Gold"] || param1.changedProperties["Money"] || param1.changedProperties["BandMoney"])
         {
            updateMoney();
         }
      }
      
      private function updateMoney() : void
      {
         goldTxt.text = String(PlayerManager.Instance.Self.Gold);
      }
      
      private function stopHandler(param1:MouseEvent) : void
      {
         _isInFusion = false;
         _inCount = Number(_inCount) - 1;
         stopContinuousView();
         refreshView(_data);
      }
      
      private function stopContinuousView() : void
      {
         _stopBtn.visible = false;
         _coverSprite.visible = false;
         FusionNewManager.instance.isInContinuousFusion = false;
      }
      
      private function startContinuousView() : void
      {
         _stopBtn.visible = true;
         _coverSprite.visible = true;
         FusionNewManager.instance.isInContinuousFusion = true;
      }
      
      private function fusionCompleteHandler(param1:PkgEvent) : void
      {
         if(_data && _data.FusionRate < 100)
         {
            if(_isInFusion)
            {
               _inCount = Number(_inCount) - 1;
               if(_inCount > 0 && checkGoldEnough())
               {
                  _inputNumTxt.text = _inCount.toString();
                  setTimeout(delayFusion,500);
               }
               else
               {
                  _isInFusion = false;
                  stopContinuousView();
                  refreshView(_data);
               }
            }
         }
      }
      
      private function delayFusion() : void
      {
         if(_isInFusion)
         {
            fusionItem(1);
         }
      }
      
      private function changeMaxHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _inputNumTxt.text = _maxNum.toString();
      }
      
      private function inputTextChangeHandler(param1:Event) : void
      {
         var _loc2_:int = _inputNumTxt.text;
         if(_loc2_ < 1)
         {
            _inputNumTxt.text = "1";
         }
         if(_loc2_ > _maxNum)
         {
            _inputNumTxt.text = _maxNum.toString();
         }
      }
      
      private function fusionHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         if(new Date().time - _clickTime > 1000)
         {
            SoundManager.instance.play("008");
            _clickTime = new Date().time;
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(!checkGoldEnough())
            {
               return;
            }
            _loc2_ = _inputNumTxt.text;
            if(_loc2_ <= 0)
            {
               return;
            }
            if(_data.FusionRate >= 100 || _loc2_ == 1)
            {
               _loc3_ = _loc2_;
               _inCount = 0;
               _isInFusion = false;
            }
            else
            {
               _loc3_ = 1;
               _inCount = _loc2_;
               _isInFusion = true;
               startContinuousView();
            }
            fusionItem(_loc3_);
         }
      }
      
      private function fusionItem(param1:int) : void
      {
         var _loc2_:* = null;
         if(_data.isNeedPopBindTipWindow(param1))
         {
            _fusionNum = param1;
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.store.newFusion.bindTipTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,2);
            _loc2_.moveEnable = false;
            _loc2_.addEventListener("response",_response2);
            _isInFusion = false;
            _inCount = Number(_inCount) - 1;
            stopContinuousView();
         }
         else
         {
            SocketManager.Instance.out.sendItemFusion(_data.FusionID,param1,_fusionAttribute.selected);
         }
      }
      
      private function _response2(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_response2);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            SocketManager.Instance.out.sendItemFusion(_data.FusionID,_fusionNum,_fusionAttribute.selected);
         }
      }
      
      private function checkGoldEnough() : Boolean
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Gold < 1600)
         {
            _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _loc1_.moveEnable = false;
            _loc1_.addEventListener("response",_responseV);
            return false;
         }
         return true;
      }
      
      private function _responseV(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            okFastPurchaseGold();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function okFastPurchaseGold() : void
      {
         var _loc1_:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _loc1_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _loc1_.itemID = 11233;
         LayerManager.Instance.addToLayer(_loc1_,2,true,1);
      }
      
      public function refreshView(param1:FusionNewVo) : void
      {
         var _loc2_:int = 0;
         if(_data != param1)
         {
            _inCount = 0;
         }
         _data = param1;
         if(_data)
         {
            if(!_isInFusion)
            {
               _fusionCell.info = _data.fusionItemInfo;
               _fusionCell.visible = true;
               _successRateTxt.text = _data.FusionRate <= 5?LanguageMgr.GetTranslation("store.fusion.preview.LowRate"):_data.FusionRate + "%";
               _successRateTxt.visible = true;
               _fusionNameTxt.text = _data.fusionItemInfo.Name;
               _fusionNameTxt.visible = true;
               _fusionAttribute.visible = param1.FusionType == 2?true:false;
               _maxNum = _data.canFusionCount;
               if(_maxNum > 0)
               {
                  _inputNumTxt.text = _inCount > 0?_inCount.toString():"1";
                  _fusionBtn.enable = true;
               }
               else
               {
                  _inputNumTxt.text = "0";
                  _fusionBtn.enable = false;
               }
               _inputNumTxt.visible = true;
               _maxBtn.enable = true;
            }
         }
         else
         {
            _fusionCell.visible = false;
            _successRateTxt.visible = false;
            _fusionNameTxt.visible = false;
            _fusionAttribute.visible = false;
            _maxNum = 0;
            _inputNumTxt.text = "0";
            _inputNumTxt.visible = false;
            _maxBtn.enable = false;
            _fusionBtn.enable = false;
         }
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _materialList[_loc2_].refreshView(_data);
            _loc2_++;
         }
      }
      
      private function removeEvent() : void
      {
         if(_fusionBtn)
         {
            _fusionBtn.removeEventListener("click",fusionHandler);
         }
         if(_stopBtn)
         {
            _stopBtn.removeEventListener("click",stopHandler);
         }
         if(_maxBtn)
         {
            _maxBtn.removeEventListener("click",changeMaxHandler);
         }
         if(_inputNumTxt)
         {
            _inputNumTxt.removeEventListener("change",inputTextChangeHandler);
         }
         SocketManager.Instance.removeEventListener(PkgEvent.format(78),fusionCompleteHandler);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _fusionBg = null;
         _successBg = null;
         _inputNumBg = null;
         _inputNumTxt = null;
         _maxBtn = null;
         _successTipTxt = null;
         _successRateTxt = null;
         _needMoneyTipTxt = null;
         _needMoneyNumTxt = null;
         _moneyIcon = null;
         _fusionBtn = null;
         _coverSprite = null;
         _stopBtn = null;
         _fusionCell = null;
         _previewTxt = null;
         _fusionNameTxt = null;
         _materialList = null;
         _data = null;
         if(_fusionAttribute)
         {
            ObjectUtils.disposeObject(_fusionAttribute);
         }
         _fusionAttribute = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
