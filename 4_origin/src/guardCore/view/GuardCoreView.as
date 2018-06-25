package guardCore.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.Experience;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import guardCore.GuardCoreManager;
   import guardCore.data.GuardCoreInfo;
   import guardCore.data.GuardCoreLevelInfo;
   
   public class GuardCoreView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _upgradeBtn:SimpleBitmapButton;
      
      private var _guardImg:Bitmap;
      
      private var _guardContainer:Sprite;
      
      private var _needGold:FilterFrameText;
      
      private var _needExp:FilterFrameText;
      
      private var _needGuard:FilterFrameText;
      
      private var _gold:FilterFrameText;
      
      private var _exp:FilterFrameText;
      
      private var _guard:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _itemList:Vector.<GuardCoreItem>;
      
      private var _itemContainer:Sprite;
      
      private var _btnHelp:BaseButton;
      
      private var _clickTime:int;
      
      public function GuardCoreView()
      {
         super();
         initEvent();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.guardCore.bg");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("guardCore.upgradeBtn");
         _needGold = ComponentFactory.Instance.creatComponentByStylename("guardCore.needText");
         PositionUtils.setPos(_needGold,"guardCore.needGoldPos");
         _needExp = ComponentFactory.Instance.creatComponentByStylename("guardCore.needText");
         PositionUtils.setPos(_needExp,"guardCore.needExpPos");
         _needGuard = ComponentFactory.Instance.creatComponentByStylename("guardCore.needText");
         PositionUtils.setPos(_needGuard,"guardCore.needGuardPos");
         _gold = ComponentFactory.Instance.creatComponentByStylename("guardCore.haveText");
         PositionUtils.setPos(_gold,"guardCore.goldPos");
         _exp = ComponentFactory.Instance.creatComponentByStylename("guardCore.haveText");
         PositionUtils.setPos(_exp,"guardCore.expPos");
         _guard = ComponentFactory.Instance.creatComponentByStylename("guardCore.haveText");
         PositionUtils.setPos(_guard,"guardCore.guardPos");
         _level = ComponentFactory.Instance.creatComponentByStylename("guardCore.guardLevelText");
         initItem();
         _guardContainer = new Sprite();
         PositionUtils.setPos(_guardContainer,"guardCore.guardIconPos");
         super.init();
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":468,
            "y":5
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.guardCore.help",408,488);
         titleText = LanguageMgr.GetTranslation("guardCore.title");
         updateView();
         updateGuardIcon();
      }
      
      private function initItem() : void
      {
         var i:int = 0;
         var item:* = null;
         _itemList = new Vector.<GuardCoreItem>(8);
         _itemContainer = new Sprite();
         PositionUtils.setPos(_itemContainer,"guardCore.containerPos");
         for(i = 0; i < 8; )
         {
            item = new GuardCoreItem(i + 1);
            _itemList[i] = item;
            item.x = int(i % 4) * 106;
            item.y = int(i / 4) * 112;
            _itemContainer.addChild(item);
            i++;
         }
      }
      
      private function updateView() : void
      {
         var guardGrade:int = PlayerManager.Instance.Self.guardCoreGrade + 1;
         var info:GuardCoreLevelInfo = GuardCoreManager.instance.getGuardLevelInfo(guardGrade);
         var gold:int = PlayerManager.Instance.Self.Gold;
         var exp:int = PlayerManager.Instance.Self.GP - Experience.expericence[PlayerManager.Instance.Self.Grade - 1];
         var guard:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(12540);
         _gold.text = countToString(gold);
         _exp.text = countToString(exp);
         _guard.text = guard.toString();
         if(info == null)
         {
            _needGold.text = "0";
            _needExp.text = "0";
            _needGuard.text = "0";
            _upgradeBtn.enable = false;
         }
         else
         {
            _needGold.text = countToString(info.Gold);
            _needExp.text = countToString(info.Exp);
            _needGuard.text = info.Guard.toString();
            _needGold.setFrame(gold >= info.Gold?1:2);
            _needExp.setFrame(exp >= info.Exp?1:2);
            _needGuard.setFrame(guard >= info.Guard?1:2);
         }
         _level.text = PlayerManager.Instance.Self.guardCoreGrade.toString();
      }
      
      private function countToString(value:int) : String
      {
         var num:int = value / 10000;
         if(num == 0)
         {
            return value.toString();
         }
         return num.toString() + LanguageMgr.GetTranslation("tenThousand");
      }
      
      private function updateGuardIcon() : void
      {
         ObjectUtils.disposeObject(_guardImg);
         var info:GuardCoreInfo = GuardCoreManager.instance.getSelfGuardCoreInfo();
         _guardImg = ComponentFactory.Instance.creatBitmap("asset.guardCore.icon" + info.Type);
         var _loc2_:* = 0.8;
         _guardImg.scaleY = _loc2_;
         _guardImg.scaleX = _loc2_;
         _guardContainer.addChild(_guardImg);
      }
      
      private function checkEquipGuardCore() : void
      {
         var info:GuardCoreInfo = GuardCoreManager.instance.getSelfGuardCoreInfo();
         var nextInfo:GuardCoreInfo = GuardCoreManager.instance.getGuardCoreInfoBySkillGrade(info.SkillGrade + 1,info.Type);
         if(nextInfo && PlayerManager.Instance.Self.guardCoreGrade >= nextInfo.GuardGrade)
         {
            SocketManager.Instance.out.sendGuardCoreEquip(nextInfo.ID);
         }
      }
      
      private function updateItemTipsData() : void
      {
         var i:int = 0;
         for(i = 0; i < _itemList.length; )
         {
            _itemList[i].updateTipsData();
            i++;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addToContent(_bg);
         addToContent(_upgradeBtn);
         addToContent(_needGold);
         addToContent(_needExp);
         addToContent(_needGuard);
         addToContent(_gold);
         addToContent(_exp);
         addToContent(_guard);
         addToContent(_level);
         addToContent(_itemContainer);
         addToContent(_guardContainer);
      }
      
      private function __onClickUpgrade(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(getTimer() - _clickTime < 2000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("carnival.clickTip"));
         }
         _clickTime = getTimer();
         if(isUpgrade())
         {
            SocketManager.Instance.out.sendGuardCoreLevelUp();
         }
      }
      
      private function isUpgrade() : Boolean
      {
         var guardGrade:int = PlayerManager.Instance.Self.guardCoreGrade + 1;
         var info:GuardCoreLevelInfo = GuardCoreManager.instance.getGuardLevelInfo(guardGrade);
         if(info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guardCore.maxTips"));
            return false;
         }
         if(PlayerManager.Instance.Self.Gold < info.Gold)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guardCore.notGold"));
            return false;
         }
         var exp:int = PlayerManager.Instance.Self.GP - Experience.expericence[PlayerManager.Instance.Self.Grade - 1];
         if(exp < info.Exp)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guardCore.notExp"));
            return false;
         }
         var count:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(12540);
         if(count < info.Guard)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guardCore.notGuard"));
            return false;
         }
         return true;
      }
      
      private function __onGuardChange(e:PlayerPropertyEvent) : void
      {
         if(e.changedProperties["GuardCoreGrade"])
         {
            updateView();
            updateItemTipsData();
            checkEquipGuardCore();
         }
         if(e.changedProperties["GuardCoreID"])
         {
            updateGuardIcon();
         }
      }
      
      override protected function onResponse(type:int) : void
      {
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",__onGuardChange);
         _upgradeBtn.addEventListener("click",__onClickUpgrade);
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__onGuardChange);
         _upgradeBtn.removeEventListener("click",__onClickUpgrade);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_itemContainer);
         ObjectUtils.disposeObject(_btnHelp);
         ObjectUtils.disposeObject(_guardImg);
         super.dispose();
         _btnHelp = null;
         _bg = null;
         _upgradeBtn = null;
         _needGold = null;
         _needExp = null;
         _needGuard = null;
         _gold = null;
         _exp = null;
         _guard = null;
         _level = null;
         _itemContainer = null;
         _itemList = null;
         _guardImg = null;
      }
   }
}
