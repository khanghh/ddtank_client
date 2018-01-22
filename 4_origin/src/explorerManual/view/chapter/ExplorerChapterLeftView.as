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
      
      public function ExplorerChapterLeftView(param1:ExplorerManualInfo, param2:ExplorerManualController)
      {
         super();
         _model = param1;
         _ctrl = param2;
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
      
      private function __materialSelectClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_materialSelectBtn.selected)
         {
            _loc3_ = ShopManager.Instance.getShopItemByGoodsID(_model.upgradeCondition.materialCondition.Parameter3);
            _loc2_ = LanguageMgr.GetTranslation("explorerManual.materialBuy.prompt",_loc3_.getItemPrice(0).bothMoneyValue);
            AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),"",true,true,false,2);
         }
      }
      
      private function __startUpgradeHandler(param1:MouseEvent) : void
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
      
      private function __manualUpgradeComplete(param1:Event) : void
      {
      }
      
      private function __autoUpgradeHandler(param1:MouseEvent) : void
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
         var _loc3_:int = _model.upgradeCondition.materialCondition.Parameter2;
         var _loc2_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(_model.upgradeCondition.materialCondition.Parameter1);
         var _loc1_:* = _loc2_ >= _loc3_;
         if(!_loc1_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("explorerManual.chapterView.upgradeMaterialNotEnough"));
         }
         return _loc1_;
      }
      
      private function checkCanClick() : Boolean
      {
         var _loc1_:Number = new Date().time;
         if(_loc1_ - _clickNum < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"),0,true);
            return false;
         }
         _clickNum = _loc1_;
         return true;
      }
      
      private function __manualProgressUpdateHandler(param1:Event) : void
      {
         updateProgress();
      }
      
      private function __manualProUpdateHandler(param1:Event) : void
      {
         updatePro();
      }
      
      private function __modelUpdateHandler(param1:Event) : void
      {
         updatePro();
         updateProgress();
         updateUpgradeMaterial();
         updateManualIcon();
         updateManualConditionDes();
      }
      
      private function __manualLevelChangle(param1:Event) : void
      {
         updateUpgradeMaterial();
         updateManualIcon();
         updateManualConditionDes();
      }
      
      private function updateManualConditionDes() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _conditionTxt.text = LanguageMgr.GetTranslation("explorerManual.manualUpgradeCondition.txt");
         var _loc1_:* = true;
         if(_model.upgradeCondition.upgradeCondition != null)
         {
            _loc3_ = _model.upgradeCondition.targetCount;
            _loc2_ = _model.conditionCount;
            _conditionTxt.text = _conditionTxt.text + (_model.upgradeCondition.upgradeCondition.Describe + " " + (_loc2_ + "/" + _loc3_));
         }
         else
         {
            _conditionTxt.text = _conditionTxt.text + LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.new");
            _loc2_ = 0;
            _loc3_ = 1;
            _loc1_ = ExplorerManualManager.instance.getManualProInfoByLev(_model.manualLev + 1) == null;
            if(iconSprite && _loc1_)
            {
               iconSprite.removeEventListener("click",__materialClickHandler);
               iconSprite.buttonMode = false;
               iconSprite.mouseEnabled = false;
            }
         }
         updateBtn(_loc2_ >= _loc3_ || !_loc1_);
      }
      
      private function updateBtn(param1:Boolean) : void
      {
         if(_startUpgradeBtn && _autoUpgradeBtn)
         {
            var _loc2_:* = param1;
            _autoUpgradeBtn.enable = _loc2_;
            _startUpgradeBtn.enable = _loc2_;
            _materialSelectBtn.enable = param1;
         }
      }
      
      private function updateManualIcon() : void
      {
         if(_manualIcon)
         {
            ObjectUtils.disposeObject(_manualIcon);
            _manualIcon = null;
         }
         var _loc1_:int = Math.min(int((_model.manualLev - 1) / 5) + 1,4);
         _manualIcon = ComponentFactory.Instance.creat("asset.explorerManual.manualIcon" + _loc1_);
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
         var _loc1_:int = _model.upgradeCondition.materialCondition == null?11183:_model.upgradeCondition.materialCondition.Parameter1;
         _materialIcon = ComponentFactory.Instance.creat("asset.explorerManual.upgradeMaterial" + _loc1_);
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
         var _loc1_:* = null;
         var _loc3_:int = _model.upgradeCondition.materialCondition.Parameter2;
         var _loc2_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(_model.upgradeCondition.materialCondition.Parameter1);
         if(_loc3_ > _loc2_)
         {
            _loc1_ = "<FONT FACE=\'Arial\' SIZE=\'14\' COLOR=\'#FF0000\' ><B>" + _loc2_ + "</B></FONT>" + "/" + _loc3_;
         }
         else
         {
            _loc1_ = _loc2_ + "/" + _loc3_;
         }
         return _loc1_;
      }
      
      private function __materialClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BuySingleGoodsView = new BuySingleGoodsView(-1);
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
         _loc2_.isDisCount = false;
         _loc2_.goodsID = int(_model.upgradeCondition.materialCondition.Parameter3);
         _loc2_.numberSelecter.valueLimit = "";
      }
      
      private function __updateBag(param1:BagEvent) : void
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
