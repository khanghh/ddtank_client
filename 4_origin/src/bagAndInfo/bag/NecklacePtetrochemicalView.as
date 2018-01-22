package bagAndInfo.bag
{
   import bagAndInfo.cell.CellFactory;
   import bagAndInfo.cell.PersonalInfoCell;
   import bagAndInfo.info.NecklaceLevelProgress;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import store.data.StoreEquipExperience;
   
   public class NecklacePtetrochemicalView extends BaseAlerFrame
   {
       
      
      private var _bg:Bitmap;
      
      private var _levelText:FilterFrameText;
      
      private var _currentLevel:FilterFrameText;
      
      private var _nextLevel:FilterFrameText;
      
      private var _numText:FilterFrameText;
      
      private var _expText:FilterFrameText;
      
      private var _progress:NecklaceLevelProgress;
      
      private var _stoneCell:PersonalInfoCell;
      
      private var _stoneInfo:InventoryItemInfo;
      
      private var _minNum:int = 1;
      
      private var _maxNum:int = 999;
      
      private var _num:int;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _lastCreatTime:int = 0;
      
      public function NecklacePtetrochemicalView()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         SocketManager.Instance.out.necklaceStrength(0,0,1);
         info = new AlertInfo(LanguageMgr.GetTranslation("bagAndInfo.bag.NecklacePtetrochemicalView.title"),"","");
         _bg = ComponentFactory.Instance.creatBitmap("asset.bagAndInfo.bag.NecklacePtetrochemicalView.bg");
         addToContent(_bg);
         _levelText = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.NecklacePtetrochemicalView.levelText");
         addToContent(_levelText);
         _currentLevel = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.NecklacePtetrochemicalView.currentLevel");
         addToContent(_currentLevel);
         _nextLevel = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.NecklacePtetrochemicalView.nextLevel");
         addToContent(_nextLevel);
         _numText = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.NecklacePtetrochemicalView.numText");
         _numText.restrict = "0-9";
         _numText.maxChars = 5;
         addToContent(_numText);
         _expText = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.NecklacePtetrochemicalView.expText");
         addToContent(_expText);
         _progress = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.info.necklaceLevelProgress");
         addToContent(_progress);
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.NecklacePtetrochemicalView.maxBtn");
         addToContent(_maxBtn);
         _progress.setProgress(20,100);
         _stoneInfo = new InventoryItemInfo();
         _stoneInfo.TemplateID = 11160;
         _stoneInfo = ItemManager.fill(_stoneInfo);
         _stoneInfo.isShowBind = false;
         _stoneCell = CellFactory.instance.createPersonalInfoCell(0,_stoneInfo) as PersonalInfoCell;
         _stoneCell.setContentSize(55,55);
         _stoneCell.setCount(0);
         PositionUtils.setPos(_stoneCell,"bagAndInfo.bag.NecklacePtetrochemicalView.cellPos");
         addToContent(_stoneCell);
         _num = 1;
         _numText.text = "1";
         var _loc1_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11160);
         if(_stoneInfo)
         {
            _stoneCell.setCount(_loc1_);
         }
         initEvent();
         updateView();
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.Self.getBag(1).addEventListener("update",__onBagUpdate);
         PlayerManager.Instance.Self.addEventListener("propertychange",__updateInfo);
         addEventListener("response",__onFrameEvent);
         _numText.addEventListener("change",__onInput);
         _maxBtn.addEventListener("click",__onMax);
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.getBag(1).removeEventListener("update",__onBagUpdate);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__updateInfo);
         removeEventListener("response",__onFrameEvent);
         _numText.removeEventListener("change",__onInput);
         _maxBtn.removeEventListener("click",__onMax);
      }
      
      protected function __onMax(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11160);
         if(_stoneInfo)
         {
            _numText.text = String(_loc2_);
            _num = _loc2_;
         }
      }
      
      protected function __updateInfo(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["necklaceExp"] || param1.changedProperties["necklaceExpAdd"])
         {
            updateView();
         }
      }
      
      protected function __onInput(param1:Event) : void
      {
         number = int(_numText.text);
      }
      
      protected function __onFrameEvent(param1:FrameEvent) : void
      {
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SoundManager.instance.playButtonSound();
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(getTimer() - _lastCreatTime > 1000)
            {
               _lastCreatTime = getTimer();
               _stoneInfo = PlayerManager.Instance.Self.getBag(1).getItemByTemplateId(11160);
               if(isStrength())
               {
                  SocketManager.Instance.out.necklaceStrength(_num,_stoneInfo.Place);
               }
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            }
         }
      }
      
      private function isStrength() : Boolean
      {
         if(!_stoneInfo || _num == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bagAndInfo.bag.NecklacePtetrochemicalView.Warning"));
            return false;
         }
         return true;
      }
      
      protected function __onBagUpdate(param1:BagEvent) : void
      {
         var _loc2_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11160);
         if(_stoneInfo)
         {
            _stoneCell.setCount(_loc2_);
         }
         else
         {
            _stoneCell.setCount(0);
            _numText.text = "1";
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      public function set number(param1:int) : void
      {
         var _loc2_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11160);
         if(param1 < _minNum)
         {
            param1 = int(_minNum);
         }
         else if(param1 > _maxNum)
         {
            param1 = int(_maxNum);
         }
         if(param1 > _loc2_)
         {
            param1 = _loc2_;
         }
         _num = param1;
         updateView();
         dispatchEvent(new Event("change"));
      }
      
      private function updateView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:int = PlayerManager.Instance.Self.necklaceExp;
         var _loc3_:int = PlayerManager.Instance.Self.necklaceExpAdd;
         var _loc6_:int = PlayerManager.Instance.Self.necklaceLevel;
         _numText.text = _num.toString();
         _expText.text = String(_loc3_);
         _levelText.text = "Lv. " + _loc6_.toString();
         var _loc5_:int = StoreEquipExperience.getNecklaceStrengthPlus(_loc6_);
         _currentLevel.text = LanguageMgr.GetTranslation("bagAndInfo.bag.NecklacePtetrochemicalView.info",_loc5_);
         if(_loc6_ < StoreEquipExperience.NECKLACE_MAX_LEVEL)
         {
            _loc4_ = StoreEquipExperience.getNecklaceStrengthPlus(_loc6_ + 1);
            _nextLevel.text = LanguageMgr.GetTranslation("bagAndInfo.bag.NecklacePtetrochemicalView.info",_loc4_);
         }
         else
         {
            _nextLevel.text = LanguageMgr.GetTranslation("bagAndInfo.bag.NecklacePtetrochemicalView.infoII");
         }
         if(_loc6_ < StoreEquipExperience.NECKLACE_MAX_LEVEL)
         {
            _progress.setProgress(StoreEquipExperience.getNecklaceCurrentlevelExp(_loc1_),StoreEquipExperience.getNecklaceCurrentlevelMaxExp(_loc6_));
         }
         else
         {
            _progress.setProgress(1,1);
         }
         var _loc2_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11160);
         if(_num > _loc2_)
         {
            if(_stoneInfo)
            {
               _numText.text = String(_loc2_);
               _num = _loc2_;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_levelText);
         _levelText = null;
         ObjectUtils.disposeObject(_currentLevel);
         _currentLevel = null;
         ObjectUtils.disposeObject(_nextLevel);
         _nextLevel = null;
         ObjectUtils.disposeObject(_numText);
         _numText = null;
         ObjectUtils.disposeObject(_expText);
         _expText = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_stoneCell);
         _stoneCell = null;
         ObjectUtils.disposeObject(_maxBtn);
         _maxBtn = null;
         super.dispose();
      }
   }
}
