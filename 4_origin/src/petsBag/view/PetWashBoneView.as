package petsBag.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import petsBag.view.item.PetBigItem;
   import petsBag.view.item.PetWashBoneGrade;
   import petsBag.view.item.PetWashBoneProItem;
   import petsBag.view.item.StarBar;
   import road7th.data.DictionaryData;
   
   public class PetWashBoneView extends Sprite implements Disposeable
   {
      
      private static const LOCK_COUNT:int = 4;
       
      
      protected var _bg:Bitmap;
      
      private var _starBar:StarBar;
      
      private var _petBigItem:PetBigItem;
      
      private var _petName:FilterFrameText;
      
      private var _lv:Bitmap;
      
      private var _lvTxt:FilterFrameText;
      
      private var _petGrade:PetWashBoneGrade;
      
      private var _goodCell:BagCell;
      
      private var _proGrowTxt:FilterFrameText;
      
      private var _proMaxTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _curPetInfo:PetInfo;
      
      private var _proItems:Array;
      
      private var _proVBox:VBox;
      
      private var _washBoneBtn:BaseButton;
      
      private var prosArr:Array;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _haveWashBoneCount:int;
      
      private var _gradeArr:Array;
      
      public function PetWashBoneView()
      {
         _gradeArr = ["B","A","S","SS","SSS"];
         _proItems = [];
         prosArr = ["BloodGrow","AttackGrow","DefenceGrow","AgilityGrow","LuckGrow"];
         super();
         initView();
         initEvent();
         updateData();
      }
      
      protected function initView() : void
      {
         var proItem:* = null;
         var i:int = 0;
         _curPetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         _bg = ComponentFactory.Instance.creat("asset.petsBage.washBone.bg");
         addChild(_bg);
         _petName = ComponentFactory.Instance.creatComponentByStylename("petsBag.text.PetName");
         addChild(_petName);
         PositionUtils.setPos(_petName,"petsBagView.washBone.petNamePos");
         _lv = ComponentFactory.Instance.creatBitmap("assets.petsBag.Lv");
         addChild(_lv);
         PositionUtils.setPos(_lv,"petsBagView.washBone.petLevPos");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.text.Lv");
         addChild(_lvTxt);
         PositionUtils.setPos(_lvTxt,"petsBagView.washBone.petLevTxtPos");
         _starBar = new StarBar();
         addChild(_starBar);
         PositionUtils.setPos(_starBar,"petsBagView.washBone.petStarPos");
         _petBigItem = ComponentFactory.Instance.creat("petsBag.petBigItem");
         _petBigItem.initTips();
         PositionUtils.setPos(_petBigItem,"petsBagView.washBone.petItesPos");
         addChild(_petBigItem);
         _petGrade = new PetWashBoneGrade();
         addChild(_petGrade);
         PositionUtils.setPos(_petGrade,"petsBag.washBone.petGradePos");
         _proGrowTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.washBone.proGrowTxt");
         addChild(_proGrowTxt);
         _proGrowTxt.text = LanguageMgr.GetTranslation("ddt.pets.washBone.proGrowTxt");
         _proMaxTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.washBone.proGrowTxt");
         addChild(_proMaxTxt);
         PositionUtils.setPos(_proMaxTxt,"petsBag.washBone.petProMaxValueTxtPos");
         _proMaxTxt.text = LanguageMgr.GetTranslation("ddt.pets.washBone.proMaxTxt");
         _proVBox = ComponentFactory.Instance.creatComponentByStylename("petsBag.washBone.proItemHBox");
         addChild(_proVBox);
         _washBoneBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.washBone.washBoneBtn");
         addChild(_washBoneBtn);
         var lockState:Array = PetsBagManager.instance().getWashProLockByPetID(_curPetInfo);
         for(i = 0; i < 5; )
         {
            proItem = new PetWashBoneProItem(prosArr[i],_curPetInfo);
            proItem.isLock = lockState[i];
            proItem.addEventListener("clickLock",__updateCostCount);
            _proVBox.addChild(proItem);
            _proItems.push(proItem);
            i++;
         }
         _goodCell = CellFactory.instance.createBagCell(0,ItemManager.fillByID(12656),false) as BagCell;
         _goodCell.info.BindType = 4;
         _goodCell.setContentSize(59,59);
         _goodCell.setBgVisible(false);
         _goodCell.PicPos = new Point(0,0);
         addChild(_goodCell);
         PositionUtils.setPos(_goodCell,"petsBagView.washBone.goodCellPos");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.washBone.descTxt");
         addChild(_descTxt);
         _descTxt.text = LanguageMgr.GetTranslation("ddt.pets.washBone.descTxt");
         updateCellCount();
      }
      
      private function __updateCostCount(evt:CEvent) : void
      {
         var proItem:PetWashBoneProItem = evt.data as PetWashBoneProItem;
         if(getProLockCount > 4)
         {
            proItem.isLock = false;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.washBone.proLockMaxCountMsg"));
            return;
         }
         updateCellCount();
      }
      
      private function updateCellCount() : void
      {
         _goodCell.setCount(getWashBoneCount + "/" + getProLockCost);
         _goodCell.refreshTbxPos();
      }
      
      private function __washBoneHandler(evt:MouseEvent) : void
      {
         var alertFrame:* = null;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_curPetInfo != null && goodCountEnough)
         {
            if(PetsBagManager.instance().activateAlertFrameShow)
            {
               alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pets.washBone.alertConfigMsg"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
               alertFrame.addEventListener("response",__onAlertFrame);
               alertFrame.setIsShowTheLog(true,LanguageMgr.GetTranslation("notAlertAgain"));
               alertFrame.selectedCheckButton.addEventListener("click",__onSelectCheckClick);
            }
            else
            {
               sendWashBone();
            }
         }
      }
      
      protected function __onSelectCheckClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var btn:SelectedCheckButton = e.currentTarget as SelectedCheckButton;
         PetsBagManager.instance().activateAlertFrameShow = !btn.selected;
      }
      
      private function __onAlertFrame(e:FrameEvent) : void
      {
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertFrame);
         alertFrame.selectedCheckButton.removeEventListener("click",__onSelectCheckClick);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            sendWashBone();
         }
         alertFrame.dispose();
      }
      
      private function updatePetPro(evt:CEvent) : void
      {
         if(_proItems && _proItems.length > 0)
         {
            _curPetInfo = PetsBagManager.instance().petModel.currentPetInfo;
            var _loc4_:int = 0;
            var _loc3_:* = _proItems;
            for each(var item in _proItems)
            {
               item.update(_curPetInfo);
            }
            updateData();
         }
      }
      
      protected function __updateBag(event:BagEvent) : void
      {
         var bag:BagInfo = event.target as BagInfo;
         var changes:Dictionary = event.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = changes;
         for each(var i in changes)
         {
            if(i.TemplateID == 12656)
            {
               updateCellCount();
            }
         }
      }
      
      private function updateData() : void
      {
         if(_curPetInfo == null)
         {
            return;
         }
         _starBar.starNum(!!_curPetInfo?_curPetInfo.StarLevel:0);
         _petBigItem.info = _curPetInfo;
         if(_petBigItem.fightImg)
         {
            _petBigItem.fightImg.visible = false;
         }
         _petGrade.info = _curPetInfo;
         _petName.text = _curPetInfo.Name;
         _lvTxt.text = !!_curPetInfo?_curPetInfo.Level.toString():"";
      }
      
      private function sendWashBone() : void
      {
         var result:Array = getProLockState();
         PetsBagManager.instance().addPetWashProItemLock(_curPetInfo.ID,result);
         PetsBagManager.instance().sendPetWashBone(_curPetInfo.Place,result[0],result[1],result[2],result[3],result[4]);
      }
      
      private function getProLockState() : Array
      {
         var item:* = null;
         var i:int = 0;
         var result:Array = [0,0,0,0,0];
         if(_proItems == null || _proItems.length <= 0)
         {
            return result;
         }
         i = 0;
         while(i < _proItems.length)
         {
            item = _proItems[i] as PetWashBoneProItem;
            if(item.isLock)
            {
               result[i] = 1;
            }
            else
            {
               result[i] = 0;
            }
            i++;
         }
         return result;
      }
      
      private function get goodCountEnough() : Boolean
      {
         var costArr:DictionaryData = ServerConfigManager.instance.petWashCost;
         var lockCount:int = getProLockCount;
         if(lockCount > 4)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.washBone.proLockMaxCountMsg"));
            return false;
         }
         if(costArr.length < lockCount)
         {
            return false;
         }
         var needCount:int = costArr[lockCount];
         var haveCount:int = getWashBoneCount;
         if(needCount > haveCount)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.washBone.goodEnoughMsg"));
            return false;
         }
         return true;
      }
      
      private function get getWashBoneCount() : int
      {
         var bagInfo:BagInfo = PlayerManager.Instance.Self.getBag(1);
         var count:int = bagInfo.getItemCountByTemplateId(_goodCell.info.TemplateID);
         return count;
      }
      
      private function get getProLockCount() : int
      {
         var result:Array = getProLockState().filter(function():*
         {
            var /*UnknownSlot*/:* = function(element:*, index:int, arr:Array):Boolean
            {
               return element == 1;
            };
            return function(element:*, index:int, arr:Array):Boolean
            {
               return element == 1;
            };
         }());
         return result.length;
      }
      
      private function get getProLockCost() : int
      {
         var lockCount:int = getProLockCount;
         var costArr:DictionaryData = ServerConfigManager.instance.petWashCost;
         if(costArr.length <= 0)
         {
            return 5;
         }
         return int(costArr[lockCount]);
      }
      
      private function initEvent() : void
      {
         _washBoneBtn.addEventListener("click",__washBoneHandler);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__updateBag);
         PlayerManager.Instance.addEventListener("updatePet",updatePetPro);
      }
      
      private function removeEvent() : void
      {
         _washBoneBtn.removeEventListener("click",__washBoneHandler);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",__updateBag);
         PlayerManager.Instance.removeEventListener("updatePet",updatePetPro);
      }
      
      public function dispose() : void
      {
         var child:* = null;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_petBigItem);
         _petBigItem = null;
         ObjectUtils.disposeObject(_starBar);
         _starBar = null;
         ObjectUtils.disposeObject(_petName);
         _petName = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_petGrade);
         _petGrade = null;
         ObjectUtils.disposeObject(_goodCell);
         _goodCell = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_washBoneBtn);
         _washBoneBtn = null;
         ObjectUtils.disposeObject(_lv);
         _lv = null;
         ObjectUtils.disposeObject(_proGrowTxt);
         _proGrowTxt = null;
         ObjectUtils.disposeObject(_proMaxTxt);
         _proMaxTxt = null;
         ObjectUtils.disposeObject(_confirmFrame);
         _confirmFrame = null;
         _gradeArr = null;
         _curPetInfo = null;
         while(_proItems && _proItems.length > 0)
         {
            child = _proItems.shift();
            child.removeEventListener("clickLock",__updateCostCount);
            ObjectUtils.disposeObject(child);
         }
         _proItems = null;
         ObjectUtils.disposeObject(_proVBox);
         _proVBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
