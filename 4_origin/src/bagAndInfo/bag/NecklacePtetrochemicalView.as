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
         var Count:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11160);
         if(_stoneInfo)
         {
            _stoneCell.setCount(Count);
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
      
      protected function __onMax(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var Count:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11160);
         if(_stoneInfo)
         {
            _numText.text = String(Count);
            _num = Count;
         }
      }
      
      protected function __updateInfo(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["necklaceExp"] || event.changedProperties["necklaceExpAdd"])
         {
            updateView();
         }
      }
      
      protected function __onInput(event:Event) : void
      {
         number = int(_numText.text);
      }
      
      protected function __onFrameEvent(event:FrameEvent) : void
      {
         if(event.responseCode == 2 || event.responseCode == 3)
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
      
      protected function __onBagUpdate(event:BagEvent) : void
      {
         var Count:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11160);
         if(_stoneInfo)
         {
            _stoneCell.setCount(Count);
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
      
      public function set number(value:int) : void
      {
         var Count:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11160);
         if(value < _minNum)
         {
            value = int(_minNum);
         }
         else if(value > _maxNum)
         {
            value = int(_maxNum);
         }
         if(value > Count)
         {
            value = Count;
         }
         _num = value;
         updateView();
         dispatchEvent(new Event("change"));
      }
      
      private function updateView() : void
      {
         var nextNecklaceStrengthPlus:int = 0;
         var necklaceExp:int = PlayerManager.Instance.Self.necklaceExp;
         var necklaceExpAdd:int = PlayerManager.Instance.Self.necklaceExpAdd;
         var necklaceLevel:int = PlayerManager.Instance.Self.necklaceLevel;
         _numText.text = _num.toString();
         _expText.text = String(necklaceExpAdd);
         _levelText.text = "Lv. " + necklaceLevel.toString();
         var necklaceStrengthPlus:int = StoreEquipExperience.getNecklaceStrengthPlus(necklaceLevel);
         _currentLevel.text = LanguageMgr.GetTranslation("bagAndInfo.bag.NecklacePtetrochemicalView.info",necklaceStrengthPlus);
         if(necklaceLevel < StoreEquipExperience.NECKLACE_MAX_LEVEL)
         {
            nextNecklaceStrengthPlus = StoreEquipExperience.getNecklaceStrengthPlus(necklaceLevel + 1);
            _nextLevel.text = LanguageMgr.GetTranslation("bagAndInfo.bag.NecklacePtetrochemicalView.info",nextNecklaceStrengthPlus);
         }
         else
         {
            _nextLevel.text = LanguageMgr.GetTranslation("bagAndInfo.bag.NecklacePtetrochemicalView.infoII");
         }
         if(necklaceLevel < StoreEquipExperience.NECKLACE_MAX_LEVEL)
         {
            _progress.setProgress(StoreEquipExperience.getNecklaceCurrentlevelExp(necklaceExp),StoreEquipExperience.getNecklaceCurrentlevelMaxExp(necklaceLevel));
         }
         else
         {
            _progress.setProgress(1,1);
         }
         var Count:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11160);
         if(_num > Count)
         {
            if(_stoneInfo)
            {
               _numText.text = String(Count);
               _num = Count;
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
