package hall.tasktrack
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import quest.QuestDescTextAnalyz;
   import quest.QuestRewardCell;
   
   public class HallTaskManuGetView extends Sprite implements Disposeable
   {
       
      
      private var _info:QuestInfo;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _getBtn:SimpleBitmapButton;
      
      public function HallTaskManuGetView(param1:QuestInfo)
      {
         super();
         _info = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.hall.taskTrack.manuGetView.bg");
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.titleTxt");
         _loc2_.text = LanguageMgr.GetTranslation("hall.taskManuGetView.titleTxt");
         var _loc3_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.descTxt");
         _loc3_.htmlText = QuestDescTextAnalyz.start(_info.Detail);
         addChild(_loc1_);
         addChild(_loc2_);
         addChild(_loc3_);
         initAwardNum();
         initAwardItem();
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.closeBtn");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.getBtn");
         addChild(_closeBtn);
         addChild(_getBtn);
      }
      
      private function checkDescTxt(param1:FilterFrameText) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(param1.textHeight > param1.height)
         {
            _loc3_ = param1.text;
            _loc4_ = _loc3_.length;
            _loc2_ = 1;
            while(param1.textHeight > param1.height)
            {
               param1.text = _loc3_.substr(0,_loc4_ - _loc2_) + "...";
               _loc2_++;
               if(_loc2_ <= 500)
               {
                  continue;
               }
               break;
            }
         }
      }
      
      private function initAwardNum() : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc5_:Array = [new Point(237,115),new Point(321,115),new Point(405,115)];
         var _loc9_:Array = [new Point(272,116),new Point(355,116),new Point(438,116)];
         var _loc8_:int = 0;
         if(_info.RewardGP > 0)
         {
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.awardNumTitleTxt");
            _loc6_.text = LanguageMgr.GetTranslation("exp");
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.awardNumValueTxt");
            _loc7_.text = _info.RewardGP.toString();
            _loc6_.x = _loc5_[_loc8_].x;
            _loc6_.y = _loc5_[_loc8_].y;
            _loc7_.x = _loc9_[_loc8_].x;
            _loc7_.y = _loc9_[_loc8_].y;
            addChild(_loc6_);
            addChild(_loc7_);
            _loc8_++;
         }
         if(_info.RewardGold > 0)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.awardNumTitleTxt");
            _loc1_.text = LanguageMgr.GetTranslation("gold");
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.awardNumValueTxt");
            _loc4_.text = _info.RewardGold.toString();
            _loc1_.x = _loc5_[_loc8_].x;
            _loc1_.y = _loc5_[_loc8_].y;
            _loc4_.x = _loc9_[_loc8_].x;
            _loc4_.y = _loc9_[_loc8_].y;
            addChild(_loc1_);
            addChild(_loc4_);
            _loc8_++;
         }
         if(_info.RewardBindMoney > 0)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.awardNumTitleTxt");
            _loc3_.text = LanguageMgr.GetTranslation("newDdtMoney");
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.awardNumValueTxt");
            _loc2_.text = _info.RewardBindMoney.toString();
            _loc3_.x = _loc5_[_loc8_].x;
            _loc3_.y = _loc5_[_loc8_].y;
            _loc2_.x = _loc9_[_loc8_].x;
            _loc2_.y = _loc9_[_loc8_].y;
            addChild(_loc3_);
            addChild(_loc2_);
            _loc8_++;
         }
      }
      
      private function initAwardItem() : void
      {
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _info.itemRewards;
         for each(var _loc2_ in _info.itemRewards)
         {
            _loc4_ = new InventoryItemInfo();
            _loc4_.TemplateID = _loc2_.itemID;
            ItemManager.fill(_loc4_);
            _loc4_.ValidDate = _loc2_.ValidateTime;
            _loc4_.IsJudge = true;
            _loc4_.IsBinds = _loc2_.isBind;
            _loc4_.AttackCompose = _loc2_.AttackCompose;
            _loc4_.DefendCompose = _loc2_.DefendCompose;
            _loc4_.AgilityCompose = _loc2_.AgilityCompose;
            _loc4_.LuckCompose = _loc2_.LuckCompose;
            _loc4_.StrengthenLevel = _loc2_.StrengthenLevel;
            if(EquipType.isMagicStone(_loc4_.CategoryID))
            {
               _loc4_.Level = _loc4_.StrengthenLevel;
               _loc4_.Attack = _loc4_.AttackCompose;
               _loc4_.Defence = _loc4_.DefendCompose;
               _loc4_.Agility = _loc4_.AgilityCompose;
               _loc4_.Luck = _loc4_.LuckCompose;
               _loc4_.MagicAttack = _loc2_.MagicAttack;
               _loc4_.MagicDefence = _loc2_.MagicDefence;
            }
            _loc4_.Count = _loc2_.count[_info.QuestLevel - 1];
            if(!(0 != _loc4_.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != _loc4_.NeedSex))
            {
               if(!_loc2_.isOptional)
               {
                  _loc1_ = new QuestRewardCell(false);
                  _loc1_.addChildAt(ComponentFactory.Instance.creatBitmap("asset.hall.taskTrack.manuGetView.cellBg"),0);
                  _loc1_.info = _loc4_;
                  _loc1_.x = 388 - 56 * _loc3_;
                  _loc1_.y = 140;
                  addChild(_loc1_);
                  _loc3_++;
               }
            }
         }
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",closeClickHandler,false,0,true);
         _getBtn.addEventListener("click",getClickHandler,false,0,true);
         SocketManager.Instance.addEventListener(PkgEvent.format(273),questManuGetHandler);
      }
      
      private function questManuGetHandler(param1:PkgEvent) : void
      {
         dispose();
      }
      
      private function closeClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function getClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendQuestManuGet(_info.id);
      }
      
      private function getSexByInt(param1:Boolean) : int
      {
         return !!param1?1:2;
      }
      
      private function removeEvent() : void
      {
         _closeBtn.removeEventListener("click",closeClickHandler);
         _getBtn.removeEventListener("click",getClickHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(273),questManuGetHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _info = null;
         _closeBtn = null;
         _getBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
