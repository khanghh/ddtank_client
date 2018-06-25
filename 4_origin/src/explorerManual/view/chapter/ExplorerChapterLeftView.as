package explorerManual.view.chapter
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import explorerManual.ExplorerManualController;
   import explorerManual.ExplorerManualManager;
   import explorerManual.data.ExplorerManualInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.view.BuySingleGoodsView;
   
   public class ExplorerChapterLeftView extends Sprite implements Disposeable
   {
       
      
      private var _manualIcon:Bitmap;
      
      private var _curPro:ManualPropertyView;
      
      private var _nextPro:ManualPropertyView;
      
      private var _progressBar:ManualPropertyPrgress;
      
      private var _startUpgradeBtn:BaseButton;
      
      private var _autoUpgradeBtn:BaseButton;
      
      private var _materialSelectBtn:SelectedCheckButton;
      
      private var _model:ExplorerManualInfo;
      
      private var _ctrl:ExplorerManualController;
      
      private var _conditionTxt:FilterFrameText;
      
      private var _materialIcon:Bitmap;
      
      private var _materialCount:FilterFrameText;
      
      private var _maxIcon:Bitmap;
      
      private var _clickNum:Number = 0;
      
      private var iconSprite:Sprite;
      
      public function ExplorerChapterLeftView(model:ExplorerManualInfo, ctrl:ExplorerManualController)
      {
         super();
         _model = model;
         _ctrl = ctrl;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _manualIcon = ComponentFactory.Instance.creat("asset.explorerManual.manualIcon1");
         addChild(_manualIcon);
         PositionUtils.setPos(_manualIcon,"explorerManual.leftChapter.manualIconPos");
         _curPro = new ManualPropertyView();
         addChild(_curPro);
         PositionUtils.setPos(_curPro,"explorerManual.curProViewPos");
         _nextPro = new ManualPropertyView();
         addChild(_nextPro);
         PositionUtils.setPos(_nextPro,"explorerManual.nextProViewPos");
         _maxIcon = ComponentFactory.Instance.creat("asset.explorerManual.maxLev");
         _maxIcon.visible = false;
         addChild(_maxIcon);
         _progressBar = new ManualPropertyPrgress(_model);
         addChild(_progressBar);
         PositionUtils.setPos(_progressBar,"explorerManual.progressBarPos");
         _materialCount = ComponentFactory.Instance.creatComponentByStylename("explorerManual.upgradeMaterial.numberTxt");
         addChild(_materialCount);
         _materialSelectBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.materialsNotEnough.selectBtn");
         addChild(_materialSelectBtn);
         _materialSelectBtn.text = LanguageMgr.GetTranslation("explorerManual.chapterView.materialNotEnough");
         _startUpgradeBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.manualLeft.startUpdateBtn");
         addChild(_startUpgradeBtn);
         _startUpgradeBtn.enable = false;
         _autoUpgradeBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.manualLeft.autoUpdateBtn");
         addChild(_autoUpgradeBtn);
         _autoUpgradeBtn.enable = false;
         _conditionTxt = ComponentFactory.Instance.creatComponentByStylename("explorerManual.upgradeCondition.txt");
         addChild(_conditionTxt);
      }
      
      private function initEvent() : void
      {
         if(_model)
         {
            _model.addEventListener("manualModelUpdate",__modelUpdateHandler);
            _model.addEventListener("manualProUpdate",__manualProUpdateHandler);
            _model.addEventListener("manualProgressUpdate",__manualProgressUpdateHandler);
            _model.addEventListener("manualLevelChangle",__manualLevelChangle);
         }
         if(_materialSelectBtn)
         {
            _materialSelectBtn.addEventListener("click",__materialSelectClickHandler);
         }
         if(_ctrl)
         {
            _ctrl.addEventListener("upgradeComplete",__manualUpgradeComplete);
         }
         if(_startUpgradeBtn)
         {
            _startUpgradeBtn.addEventListener("click",__startUpgradeHandler);
         }
         if(_autoUpgradeBtn)
         {
            _autoUpgradeBtn.addEventListener("click",__autoUpgradeHandler);
         }
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__updateBag);
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("manualModelUpdate",__modelUpdateHandler);
            _model.removeEventListener("manualProUpdate",__manualProUpdateHandler);
            _model.removeEventListener("manualProgressUpdate",__manualProgressUpdateHandler);
            _model.removeEventListener("manualLevelChangle",__manualLevelChangle);
         }
         if(_materialSelectBtn)
         {
            _materialSelectBtn.removeEventListener("click",__materialSelectClickHandler);
         }
         if(_ctrl)
         {
            _ctrl.removeEventListener("upgradeComplete",__manualUpgradeComplete);
         }
         if(_startUpgradeBtn)
         {
            _startUpgradeBtn.removeEventListener("click",__startUpgradeHandler);
         }
         if(_autoUpgradeBtn)
         {
            _autoUpgradeBtn.removeEventListener("click",__autoUpgradeHandler);
         }
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",__updateBag);
      }
      
      private function __materialSelectClickHandler(evt:MouseEvent) : void
      {
         var shopItemInfo:* = null;
         var price:* = null;
         if(_materialSelectBtn.selected)
         {
            shopItemInfo = ShopManager.Instance.getShopItemByGoodsID(_model.upgradeCondition.materialCondition.Parameter3);
            price = LanguageMgr.GetTranslation("explorerManual.materialBuy.prompt",shopItemInfo.getItemPrice(0).bothMoneyValue);
            AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),price,LanguageMgr.GetTranslation("ok"),"",true,true,false,2);
         }
      }
      
      private function __startUpgradeHandler(evt:MouseEvent) : void
      {
         if(checkCanClick())
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(_ctrl)
            {
               if(_materialSelectBtn.selected || isCanUpgrade())
               {
                  _ctrl.startUpgrade(_materialSelectBtn.selected,false);
               }
            }
         }
      }
      
      private function __manualUpgradeComplete(evt:Event) : void
      {
      }
      
      private function __autoUpgradeHandler(evt:MouseEvent) : void
      {
         if(checkCanClick())
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(_ctrl)
            {
               if(_materialSelectBtn.selected || isCanUpgrade())
               {
                  _ctrl.autoUpgrade(_materialSelectBtn.selected,false,true);
               }
            }
         }
      }
      
      private function isCanUpgrade() : Boolean
      {
         var needN:int = _model.upgradeCondition.materialCondition.Parameter2;
         var haveN:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(_model.upgradeCondition.materialCondition.Parameter1);
         var result:* = haveN >= needN;
         if(!result)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("explorerManual.chapterView.upgradeMaterialNotEnough"));
         }
         return result;
      }
      
      private function checkCanClick() : Boolean
      {
         var nowTime:Number = new Date().time;
         if(nowTime - _clickNum < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"),0,true);
            return false;
         }
         _clickNum = nowTime;
         return true;
      }
      
      private function __manualProgressUpdateHandler(evt:Event) : void
      {
         updateProgress();
      }
      
      private function __manualProUpdateHandler(evt:Event) : void
      {
         updatePro();
      }
      
      private function __modelUpdateHandler(evt:Event) : void
      {
         updatePro();
         updateProgress();
         updateUpgradeMaterial();
         updateManualIcon();
         updateManualConditionDes();
      }
      
      private function __manualLevelChangle(evt:Event) : void
      {
         updateUpgradeMaterial();
         updateManualIcon();
         updateManualConditionDes();
      }
      
      private function updateManualConditionDes() : void
      {
         var tartCount:int = 0;
         var compleCount:int = 0;
         _conditionTxt.text = LanguageMgr.GetTranslation("explorerManual.manualUpgradeCondition.txt");
         var isMaxLev:* = true;
         if(_model.upgradeCondition.upgradeCondition != null)
         {
            tartCount = _model.upgradeCondition.targetCount;
            compleCount = _model.conditionCount;
            _conditionTxt.text = _conditionTxt.text + (_model.upgradeCondition.upgradeCondition.Describe + " " + (compleCount + "/" + tartCount));
         }
         else
         {
            _conditionTxt.text = _conditionTxt.text + LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.new");
            compleCount = 0;
            tartCount = 1;
            isMaxLev = ExplorerManualManager.instance.getManualProInfoByLev(_model.manualLev + 1) == null;
            if(iconSprite && isMaxLev)
            {
               iconSprite.removeEventListener("click",__materialClickHandler);
               iconSprite.buttonMode = false;
               iconSprite.mouseEnabled = false;
            }
         }
         updateBtn(compleCount >= tartCount || !isMaxLev);
      }
      
      private function updateBtn(canClick:Boolean) : void
      {
         if(_startUpgradeBtn && _autoUpgradeBtn)
         {
            var _loc2_:* = canClick;
            _autoUpgradeBtn.enable = _loc2_;
            _startUpgradeBtn.enable = _loc2_;
            _materialSelectBtn.enable = canClick;
         }
      }
      
      private function updateManualIcon() : void
      {
         if(_manualIcon)
         {
            ObjectUtils.disposeObject(_manualIcon);
            _manualIcon = null;
         }
         var type:int = Math.min(int((_model.manualLev - 1) / 5) + 1,4);
         _manualIcon = ComponentFactory.Instance.creat("asset.explorerManual.manualIcon" + type);
         addChild(_manualIcon);
         PositionUtils.setPos(_manualIcon,"explorerManual.leftChapter.manualIconPos");
      }
      
      private function updateUpgradeMaterial() : void
      {
         if(iconSprite)
         {
            iconSprite.removeEventListener("click",__materialClickHandler);
            iconSprite.removeChildren();
            if(iconSprite.parent)
            {
               iconSprite.parent.removeChild(iconSprite);
            }
         }
         _materialIcon = null;
         iconSprite = new Sprite();
         iconSprite.buttonMode = true;
         iconSprite.mouseEnabled = true;
         addChild(iconSprite);
         iconSprite.x = 112;
         iconSprite.y = 398;
         var materialID:int = _model.upgradeCondition.materialCondition == null?11183:_model.upgradeCondition.materialCondition.Parameter1;
         _materialIcon = ComponentFactory.Instance.creat("asset.explorerManual.upgradeMaterial" + materialID);
         iconSprite.addChild(_materialIcon);
         iconSprite.addEventListener("click",__materialClickHandler);
         updateMaterialCount();
      }
      
      private function updateMaterialCount() : void
      {
         if(_model.upgradeCondition.materialCondition == null)
         {
            _materialCount.htmlText = "0/0";
         }
         else
         {
            _materialCount.htmlText = getMaterCountTxt;
         }
      }
      
      private function get getMaterCountTxt() : String
      {
         var result:* = null;
         var needN:int = _model.upgradeCondition.materialCondition.Parameter2;
         var haveN:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(_model.upgradeCondition.materialCondition.Parameter1);
         if(needN > haveN)
         {
            result = "<FONT FACE=\'Arial\' SIZE=\'14\' COLOR=\'#FF0000\' ><B>" + haveN + "</B></FONT>" + "/" + needN;
         }
         else
         {
            result = haveN + "/" + needN;
         }
         return result;
      }
      
      private function __materialClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _buyFrame:BuySingleGoodsView = new BuySingleGoodsView(-1);
         LayerManager.Instance.addToLayer(_buyFrame,3,true,1);
         _buyFrame.isDisCount = false;
         _buyFrame.goodsID = int(_model.upgradeCondition.materialCondition.Parameter3);
         _buyFrame.numberSelecter.valueLimit = "";
      }
      
      private function __updateBag(evt:BagEvent) : void
      {
         updateMaterialCount();
      }
      
      private function updatePro() : void
      {
         if(_curPro)
         {
            _curPro.info = _model.curPro;
         }
         if(_nextPro)
         {
            _nextPro.info = _model.nextPro;
         }
         if(_model.nextPro == null)
         {
            updateBtn(false);
            _maxIcon.visible = true;
            _nextPro.visible = false;
         }
      }
      
      private function updateProgress() : void
      {
         if(_progressBar)
         {
            _progressBar.setProgress(_model.progress,_model.proLevMaxProgress);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_curPro);
         _curPro = null;
         ObjectUtils.disposeObject(_manualIcon);
         _manualIcon = null;
         if(iconSprite)
         {
            iconSprite.removeEventListener("click",__materialClickHandler);
            iconSprite.removeChildren();
            if(iconSprite.parent)
            {
               iconSprite.parent.removeChild(iconSprite);
            }
         }
         ObjectUtils.disposeObject(_nextPro);
         _nextPro = null;
         ObjectUtils.disposeObject(_progressBar);
         _progressBar = null;
         ObjectUtils.disposeObject(_materialSelectBtn);
         _materialSelectBtn = null;
         ObjectUtils.disposeObject(_startUpgradeBtn);
         _startUpgradeBtn = null;
         ObjectUtils.disposeObject(_autoUpgradeBtn);
         _autoUpgradeBtn = null;
      }
   }
}
