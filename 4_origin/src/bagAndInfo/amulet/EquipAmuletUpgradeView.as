package bagAndInfo.amulet
{
   import bagAndInfo.amulet.vo.EquipAmuletVo;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class EquipAmuletUpgradeView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _upgradeBtn:SimpleBitmapButton;
      
      private var _promote:Bitmap;
      
      private var _maxLevel:Bitmap;
      
      private var _oldCell:BagCell;
      
      private var _newCell:BagCell;
      
      private var _oldLevelText:FilterFrameText;
      
      private var _oldHpText:FilterFrameText;
      
      private var _newLevelText:FilterFrameText;
      
      private var _newHpText:FilterFrameText;
      
      private var _upgradeTipText:FilterFrameText;
      
      private var _propCell:BagCell;
      
      private var _upgradeAllBtn:SelectedCheckButton;
      
      private var _currentTime:Number;
      
      private var _info:InventoryItemInfo;
      
      public function EquipAmuletUpgradeView()
      {
         super();
         init();
         initCell();
         initEvent();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.equipAmulet.upgradeView");
         addChild(_bg);
         _promote = ComponentFactory.Instance.creatBitmap("asset.equipAmulet.promote");
         _promote.visible = false;
         addChild(_promote);
         _maxLevel = ComponentFactory.Instance.creatBitmap("asset.equipAmulet.maxLevel");
         _maxLevel.visible = false;
         addChild(_maxLevel);
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.upgradeBtn");
         addChild(_upgradeBtn);
         _oldLevelText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.oldPropertyText");
         PositionUtils.setPos(_oldLevelText,"equipAmulet.oldLevelTextPos");
         addChild(_oldLevelText);
         _oldHpText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.oldPropertyText");
         PositionUtils.setPos(_oldHpText,"equipAmulet.oldHpTextPos");
         addChild(_oldHpText);
         _newLevelText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.newPropertyText");
         PositionUtils.setPos(_newLevelText,"equipAmulet.newLevelTextPos");
         addChild(_newLevelText);
         _newHpText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.newPropertyText");
         PositionUtils.setPos(_newHpText,"equipAmulet.newHpTextPos");
         addChild(_newHpText);
         _upgradeTipText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.upgradeTipText");
         _upgradeTipText.htmlText = LanguageMgr.GetTranslation("tank.equipAmulet.upgradeTip",100);
         addChild(_upgradeTipText);
         _upgradeAllBtn = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.upgradeAllBtn");
         addChild(_upgradeAllBtn);
      }
      
      private function initCell() : void
      {
         var cellBg:* = null;
         _info = PlayerManager.Instance.Self.Bag.items[18];
         cellBg = new Shape();
         cellBg.graphics.beginFill(0,0);
         cellBg.graphics.drawRect(0,0,60,60);
         cellBg.graphics.endFill();
         _oldCell = new BagCell(0,_info,true,cellBg);
         PositionUtils.setPos(_oldCell,"equipAmulet.oldCellPos");
         addChild(_oldCell);
         cellBg = new Shape();
         cellBg.graphics.beginFill(0,0);
         cellBg.graphics.drawRect(0,0,70,70);
         cellBg.graphics.endFill();
         _newCell = new BagCell(0,null,true,cellBg);
         PositionUtils.setPos(_newCell,"equipAmulet.newCellPos");
         addChild(_newCell);
         var wishInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(stoneTemtID);
         cellBg = new Shape();
         cellBg.graphics.beginFill(0,0);
         cellBg.graphics.drawRect(0,0,48,48);
         cellBg.graphics.endFill();
         _propCell = new BagCell(0,wishInfo,true,cellBg);
         PositionUtils.setPos(_propCell,"equipAmulet.propCellPos");
         addChild(_propCell);
      }
      
      protected function __onClickUpgradeBtn(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(getTimer() - _currentTime < 1500)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("carnival.clickTip"));
            return;
         }
         _currentTime = getTimer();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var vo:EquipAmuletVo = EquipAmuletManager.Instance.getAmuletVo(_info.StrengthenLevel + 1);
         if(vo == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.fullGrade"));
            return;
         }
         if(_propCell.getCount() <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.notUpgradeGoods"));
            return;
         }
         SocketManager.Instance.out.sendEquipAmuletUpgrade(_upgradeAllBtn.selected);
      }
      
      public function update(allUpdate:Boolean = true) : void
      {
         var grade:int = 0;
         var times:int = 0;
         if(_propCell.info.TemplateID != stoneTemtID)
         {
            _propCell.info = ItemManager.Instance.getTemplateById(stoneTemtID);
         }
         var bagInfo:BagInfo = PlayerManager.Instance.Self.getBag(1);
         _propCell.setCount(bagInfo.getItemCountByTemplateId(_propCell.info.TemplateID));
         var newInfo:InventoryItemInfo = _newCell.info as InventoryItemInfo;
         var vo:EquipAmuletVo = EquipAmuletManager.Instance.getAmuletVo(_info.StrengthenLevel + 1);
         var oldVo:EquipAmuletVo = EquipAmuletManager.Instance.getAmuletVo(_info.StrengthenLevel);
         if(allUpdate)
         {
            grade = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(_info.StrengthenLevel).grade;
            if(grade == _info.StrengthenLevel && grade != 1)
            {
               _oldCell.resetLoadIcon();
            }
            _promote.visible = false;
            _maxLevel.visible = false;
            if(vo == null)
            {
               _maxLevel.visible = true;
               newInfo = _info;
            }
            else
            {
               if(oldVo.phase == vo.phase - 1)
               {
                  _promote.visible = true;
               }
               newInfo = ItemManager.copy(_info);
               newInfo.StrengthenLevel = _info.StrengthenLevel + 1;
            }
            _newCell.info = newInfo;
         }
         _oldLevelText.text = _info.StrengthenLevel.toString();
         _oldHpText.text = EquipAmuletManager.Instance.getAmuletVo(_info.StrengthenLevel).HP.toString();
         _newLevelText.text = newInfo.StrengthenLevel.toString();
         _newHpText.text = EquipAmuletManager.Instance.getAmuletVo(newInfo.StrengthenLevel).HP.toString();
         if(vo == null)
         {
            _upgradeTipText.visible = false;
            _newLevelText.text = LanguageMgr.GetTranslation("tank.equipAmulet.maxGrade");
         }
         else
         {
            _upgradeTipText.visible = true;
            times = EquipAmuletManager.Instance.getAmuletVo(_info.StrengthenLevel).GuaranteeTimes - _info.StrengthenTimes;
            _upgradeTipText.htmlText = LanguageMgr.GetTranslation("tank.equipAmulet.upgradeTip",times);
         }
      }
      
      private function __onUpgradeComplete(e:PkgEvent) : void
      {
         var tip:* = null;
         var alertFrame:* = null;
         var bool:Boolean = e.pkg.readBoolean();
         var consume:int = e.pkg.readInt();
         _info.StrengthenLevel = e.pkg.readInt();
         _info.StrengthenTimes = e.pkg.readInt();
         if(bool)
         {
            tip = LanguageMgr.GetTranslation("tank.equipAmulet.upgradeComplete",_info.StrengthenLevel,_propCell.info.Name,consume);
            alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),tip,LanguageMgr.GetTranslation("ok"),"",false,true,false,2,null,"SimpleAlert",60,false);
            alertFrame.addEventListener("response",__onAlertCompleteFrame);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.upgradeFail"));
         }
         update(bool);
      }
      
      private function __onAlertCompleteFrame(e:FrameEvent) : void
      {
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertCompleteFrame);
         alertFrame.dispose();
      }
      
      private function initEvent() : void
      {
         _upgradeBtn.addEventListener("click",__onClickUpgradeBtn);
         SocketManager.Instance.addEventListener(PkgEvent.format(386,2),__onUpgradeComplete);
      }
      
      private function removeEvent() : void
      {
         _upgradeBtn.removeEventListener("click",__onClickUpgradeBtn);
         SocketManager.Instance.removeEventListener(PkgEvent.format(386,2),__onUpgradeComplete);
      }
      
      private function get stoneTemtID() : int
      {
         return EquipAmuletManager.Instance.getAmuletVo(_info.StrengthenLevel).consumeTempletID;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _upgradeBtn = null;
         _upgradeAllBtn = null;
         _promote = null;
         _info = null;
         _upgradeTipText = null;
         _maxLevel = null;
      }
   }
}
