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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _itemList = new Vector.<GuardCoreItem>(8);
         _itemContainer = new Sprite();
         PositionUtils.setPos(_itemContainer,"guardCore.containerPos");
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new GuardCoreItem(_loc2_ + 1);
            _itemList[_loc2_] = _loc1_;
            _loc1_.x = int(_loc2_ % 4) * 106;
            _loc1_.y = int(_loc2_ / 4) * 112;
            _itemContainer.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function updateView() : void
      {
         var _loc3_:int = PlayerManager.Instance.Self.guardCoreGrade + 1;
         var _loc5_:GuardCoreLevelInfo = GuardCoreManager.instance.getGuardLevelInfo(_loc3_);
         var _loc4_:int = PlayerManager.Instance.Self.Gold;
         var _loc1_:int = PlayerManager.Instance.Self.GP - Experience.expericence[PlayerManager.Instance.Self.Grade - 1];
         var _loc2_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(12540);
         _gold.text = countToString(_loc4_);
         _exp.text = countToString(_loc1_);
         _guard.text = _loc2_.toString();
         if(_loc5_ == null)
         {
            _needGold.text = "0";
            _needExp.text = "0";
            _needGuard.text = "0";
            _upgradeBtn.enable = false;
         }
         else
         {
            _needGold.text = countToString(_loc5_.Gold);
            _needExp.text = countToString(_loc5_.Exp);
            _needGuard.text = _loc5_.Guard.toString();
            _needGold.setFrame(_loc4_ >= _loc5_.Gold?1:2);
            _needExp.setFrame(_loc1_ >= _loc5_.Exp?1:2);
            _needGuard.setFrame(_loc2_ >= _loc5_.Guard?1:2);
         }
         _level.text = PlayerManager.Instance.Self.guardCoreGrade.toString();
      }
      
      private function countToString(param1:int) : String
      {
         var _loc2_:int = param1 / 10000;
         if(_loc2_ == 0)
         {
            return param1.toString();
         }
         return _loc2_.toString() + LanguageMgr.GetTranslation("tenThousand");
      }
      
      private function updateGuardIcon() : void
      {
         ObjectUtils.disposeObject(_guardImg);
         var _loc1_:GuardCoreInfo = GuardCoreManager.instance.getSelfGuardCoreInfo();
         _guardImg = ComponentFactory.Instance.creatBitmap("asset.guardCore.icon" + _loc1_.Type);
         var _loc2_:* = 0.8;
         _guardImg.scaleY = _loc2_;
         _guardImg.scaleX = _loc2_;
         _guardContainer.addChild(_guardImg);
      }
      
      private function checkEquipGuardCore() : void
      {
         var _loc2_:GuardCoreInfo = GuardCoreManager.instance.getSelfGuardCoreInfo();
         var _loc1_:GuardCoreInfo = GuardCoreManager.instance.getGuardCoreInfoBySkillGrade(_loc2_.SkillGrade + 1,_loc2_.Type);
         if(_loc1_ && PlayerManager.Instance.Self.guardCoreGrade >= _loc1_.GuardGrade)
         {
            SocketManager.Instance.out.sendGuardCoreEquip(_loc1_.ID);
         }
      }
      
      private function updateItemTipsData() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            _itemList[_loc1_].updateTipsData();
            _loc1_++;
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
      
      private function __onClickUpgrade(param1:MouseEvent) : void
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
         var _loc3_:int = PlayerManager.Instance.Self.guardCoreGrade + 1;
         var _loc4_:GuardCoreLevelInfo = GuardCoreManager.instance.getGuardLevelInfo(_loc3_);
         if(_loc4_ == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guardCore.maxTips"));
            return false;
         }
         if(PlayerManager.Instance.Self.Gold < _loc4_.Gold)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guardCore.notGold"));
            return false;
         }
         var _loc1_:int = PlayerManager.Instance.Self.GP - Experience.expericence[PlayerManager.Instance.Self.Grade - 1];
         if(_loc1_ < _loc4_.Exp)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guardCore.notExp"));
            return false;
         }
         var _loc2_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(12540);
         if(_loc2_ < _loc4_.Guard)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guardCore.notGuard"));
            return false;
         }
         return true;
      }
      
      private function __onGuardChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["GuardCoreGrade"])
         {
            updateView();
            updateItemTipsData();
            checkEquipGuardCore();
         }
         if(param1.changedProperties["GuardCoreID"])
         {
            updateGuardIcon();
         }
      }
      
      override protected function onResponse(param1:int) : void
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
