package quest
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.quest.QuestImproveInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class QuestinfoAwardItemView extends QuestInfoItemView
   {
       
      
      private const ROW_HEIGHT:int = 24;
      
      private const ROW_X:int = 18;
      
      private const REWARDCELL_HEIGHT:int = 55;
      
      private var _isOptional:Boolean;
      
      private var _list:SimpleTileList;
      
      private var _items:Vector.<QuestRewardCell>;
      
      private var cardAsset:ScaleFrameImage;
      
      private var _improveBtn:BaseButton;
      
      private var _isReward:Boolean;
      
      private var _improveFrame:QuestImproveFrame;
      
      private var _multiplemax:Bitmap;
      
      private var _multipleX:Bitmap;
      
      private var _number:NumberImage;
      
      private var _first:Boolean;
      
      public function QuestinfoAwardItemView(param1:Boolean)
      {
         _isOptional = param1;
         _first = true;
         _items = new Vector.<QuestRewardCell>();
         super();
      }
      
      public function set isReward(param1:Boolean) : void
      {
         _isReward = param1;
      }
      
      override public function set info(param1:QuestInfo) : void
      {
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         _info = param1;
         var _loc10_:int = 0;
         var _loc9_:* = _info.itemRewards;
         for each(var _loc7_ in _info.itemRewards)
         {
            _loc8_ = new InventoryItemInfo();
            _loc8_.TemplateID = _loc7_.itemID;
            ItemManager.fill(_loc8_);
            _loc8_.ValidDate = _loc7_.ValidateTime;
            _loc8_.IsJudge = true;
            _loc8_.IsBinds = _loc7_.isBind;
            _loc8_.AttackCompose = _loc7_.AttackCompose;
            _loc8_.DefendCompose = _loc7_.DefendCompose;
            _loc8_.AgilityCompose = _loc7_.AgilityCompose;
            _loc8_.LuckCompose = _loc7_.LuckCompose;
            _loc8_.StrengthenLevel = _loc7_.StrengthenLevel;
            _loc8_.Count = _loc7_.count[_info.QuestLevel - 1];
            if(EquipType.isMagicStone(_loc8_.CategoryID))
            {
               _loc8_.Level = _loc8_.StrengthenLevel;
               _loc8_.Attack = _loc8_.AttackCompose;
               _loc8_.Defence = _loc8_.DefendCompose;
               _loc8_.Agility = _loc8_.AgilityCompose;
               _loc8_.Luck = _loc8_.LuckCompose;
               _loc8_.MagicAttack = _loc7_.MagicAttack;
               _loc8_.MagicDefence = _loc7_.MagicDefence;
            }
            if(!(0 != _loc8_.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != _loc8_.NeedSex))
            {
               if(_loc7_.isOptional == _isOptional)
               {
                  _loc4_ = new QuestRewardCell();
                  _loc4_.info = _loc8_;
                  if(_loc7_.isOptional)
                  {
                     _loc4_.canBeSelected();
                     _loc4_.addEventListener(RewardSelectedEvent.ITEM_SELECTED,__chooseItemReward);
                  }
                  _list.addChild(_loc4_);
                  _items.push(_loc4_);
               }
            }
         }
         _panel.invalidateViewport();
         if(_isOptional)
         {
            return;
         }
         if(!_info.hasOtherAward())
         {
            _list.y = 5;
         }
         var _loc2_:int = 0;
         var _loc6_:QuestInfo = newInfo(_info,_info.QuestLevel - 2,TaskManager.instance.improve);
         if(_loc6_.RewardGP > 0)
         {
            addReward("exp",_loc6_.RewardGP,_loc2_);
            _loc2_++;
         }
         if(_loc6_.RewardGold > 0)
         {
            addReward("gold",_loc6_.RewardGold,_loc2_);
            _loc2_++;
         }
         if(_loc6_.RewardMoney > 0)
         {
            addReward("coin",_loc6_.RewardMoney,_loc2_);
            _loc2_++;
         }
         if(_loc6_.RewardOffer > 0)
         {
            addReward("honor",_loc6_.RewardOffer,_loc2_);
            _loc2_++;
         }
         if(_info.RewardRiches > 0)
         {
            addReward("rich",_info.RewardRiches,_loc2_);
            _loc2_++;
         }
         if(_info.RewardBindMoney > 0)
         {
            addReward("gift",_info.RewardBindMoney,_loc2_);
            _loc2_++;
         }
         if(_info.Rank != "")
         {
            addReward("rank",0,_loc2_,true,_info.Rank);
            _loc2_++;
         }
         if(_info.RewardBuffID != 0)
         {
            cardAsset = ComponentFactory.Instance.creat("core.quest.MCQuestRewardBuff");
            addChild(cardAsset);
            cardAsset.setFrame(_info.RewardBuffID - 11994);
            _loc3_ = _info.RewardBuffDate;
            _loc5_ = ComponentFactory.Instance.creat("core.quest.QuestItemRewardQuantity");
            addChild(_loc5_);
            _loc5_.x = cardAsset.x + cardAsset.width + 2;
            _loc5_.y = cardAsset.y;
            _loc5_.text = String(_loc3_) + LanguageMgr.GetTranslation("hours");
         }
         if(_isReward && getNeedMoney(_info) != -1)
         {
            _improveBtn = ComponentFactory.Instance.creatComponentByStylename("quest.improve");
            if(height > 75)
            {
               _improveBtn.y = height / 2 - 40;
            }
            else
            {
               _improveBtn.y = 20;
            }
            _content.addChild(_improveBtn);
            if(_info.QuestLevel >= 5)
            {
               _improveBtn.enable = false;
            }
            _improveBtn.addEventListener("click",_activeimproveBtnClick);
         }
         if(_info.Type == 12 && TaskManager.rewardTaskMultiple > 0)
         {
            _multipleX.visible = true;
            _number.visible = true;
            _number.count = TaskManager.rewardTaskMultiple;
            if(TaskManager.rewardTaskMultiple == 5)
            {
               _multiplemax.visible = true;
            }
            else
            {
               _multiplemax.visible = false;
            }
         }
      }
      
      private function getNeedMoney(param1:QuestInfo) : int
      {
         if(param1.QuestLevel == 1)
         {
            return param1.Level2NeedMoney;
         }
         if(param1.QuestLevel == 2)
         {
            return param1.Level3NeedMoney;
         }
         if(param1.QuestLevel == 3)
         {
            return param1.Level4NeedMoney;
         }
         if(param1.QuestLevel == 4)
         {
            return param1.Level5NeedMoney;
         }
         return -1;
      }
      
      private function newInfo(param1:QuestInfo, param2:int, param3:QuestImproveInfo) : QuestInfo
      {
         var _loc4_:* = null;
         if(param2 > -1)
         {
            _loc4_ = new QuestInfo();
            _loc4_.RewardMoney = param3.bindMoneyRate[param2] * param1.RewardMoney;
            _loc4_.RewardGP = param3.expRate[param2] * param1.RewardGP;
            _loc4_.RewardGold = param3.goldRate[param2] * param1.RewardGold;
            _loc4_.RewardOffer = param3.exploitRate[param2] * param1.RewardOffer;
            return _loc4_;
         }
         return param1;
      }
      
      private function _activeimproveBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _improveFrame = ComponentFactory.Instance.creat("quest.improveFrame");
         _improveFrame.isOptional = _isOptional;
         _improveFrame.spand = getNeedMoney(_info);
         _improveFrame.questInfo = getImproveInfo(TaskManager.instance.improve,_info.QuestLevel - 1);
         LayerManager.Instance.addToLayer(_improveFrame,3,true,1);
      }
      
      private function getImproveInfo(param1:QuestImproveInfo, param2:int) : QuestInfo
      {
         var _loc4_:QuestInfo = new QuestInfo();
         ObjectUtils.copyProperties(_loc4_,_info);
         _loc4_.data = _info.data;
         _loc4_.RewardMoney = _loc4_.RewardMoney * param1.bindMoneyRate[param2];
         _loc4_.RewardGP = _loc4_.RewardGP * param1.expRate[param2];
         _loc4_.RewardGold = _loc4_.RewardGold * param1.goldRate[param2];
         _loc4_.RewardOffer = _loc4_.RewardOffer * param1.exploitRate[param2];
         var _loc6_:int = 0;
         var _loc5_:* = _info.itemRewards;
         for each(var _loc3_ in _info.itemRewards)
         {
            _loc4_.addReward(_loc3_);
         }
         return _loc4_;
      }
      
      private function __chooseItemReward(param1:RewardSelectedEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc2_ in _items)
         {
            _loc2_.selected = false;
         }
         param1.itemCell.selected = true;
      }
      
      private function getSexByInt(param1:Boolean) : int
      {
         return !!param1?1:2;
      }
      
      private function addReward(param1:String, param2:int, param3:int, param4:Boolean = false, param5:String = "") : void
      {
         var _loc7_:FilterFrameText = ComponentFactory.Instance.creat("core.quest.MCQuestRewardType");
         if(param3 > 3)
         {
            _loc7_.y = _loc7_.y + 20;
            if(_first)
            {
               _list.y = _list.y + 20;
               _first = false;
            }
         }
         var _loc6_:FilterFrameText = ComponentFactory.Instance.creat("core.quest.QuestItemRewardQuantity");
         var _loc8_:* = param1;
         if("exp" !== _loc8_)
         {
            if("gold" !== _loc8_)
            {
               if("coin" !== _loc8_)
               {
                  if("rich" !== _loc8_)
                  {
                     if("honor" !== _loc8_)
                     {
                        if("bandMoney" !== _loc8_)
                        {
                           if("gift" !== _loc8_)
                           {
                              if("medal" !== _loc8_)
                              {
                                 if("rank" === _loc8_)
                                 {
                                    _loc7_.text = LanguageMgr.GetTranslation("tank.view.effort.EffortRigthItemView.honorNameII");
                                 }
                              }
                              else
                              {
                                 _loc7_.text = LanguageMgr.GetTranslation("gift");
                              }
                           }
                           else
                           {
                              _loc7_.text = LanguageMgr.GetTranslation("medalMoney");
                           }
                        }
                        else
                        {
                           _loc7_.text = LanguageMgr.GetTranslation("ddtMoney");
                        }
                     }
                     else
                     {
                        _loc7_.text = StringUtils.trim(LanguageMgr.GetTranslation("gongxun"));
                     }
                  }
                  else
                  {
                     _loc7_.text = LanguageMgr.GetTranslation("consortia.Money");
                  }
               }
               else
               {
                  _loc7_.text = LanguageMgr.GetTranslation("money");
               }
            }
            else
            {
               _loc7_.text = LanguageMgr.GetTranslation("gold");
            }
         }
         else
         {
            _loc7_.text = LanguageMgr.GetTranslation("exp");
         }
         if(param3 < 2)
         {
            _loc7_.x = param3 % 4 * 135 + 18;
         }
         else
         {
            _loc7_.x = param3 % 4 * 110 + 18;
         }
         _loc6_.x = _loc7_.x + _loc7_.textWidth + 5;
         _loc6_.y = _loc7_.y;
         if(param4)
         {
            _loc6_.text = param5;
         }
         else
         {
            _loc6_.text = String(param2);
         }
         _content.addChildAt(_loc7_,0);
         _content.addChildAt(_loc6_,0);
      }
      
      override protected function initView() : void
      {
         super.initView();
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("core.quest.eligiblyWord");
         _titleImg.setFrame(!!_isOptional?1:2);
         addChild(_titleImg);
         _list = new SimpleTileList(2);
         if(!_isOptional)
         {
            PositionUtils.setPos(_list,"quest.awardPanel.listpos");
         }
         else
         {
            PositionUtils.setPos(_list,"quest.awardPanel.listpos1");
         }
         _content.addChild(_list);
         _multipleX = ComponentFactory.Instance.creatBitmap("asset.core.quest.rewardTask.multiplex");
         _number = ComponentFactory.Instance.creatComponentByStylename("quest.multiple");
         var _loc1_:* = 0.9;
         _number.scaleY = _loc1_;
         _number.scaleX = _loc1_;
         _multiplemax = ComponentFactory.Instance.creatBitmap("asset.core.quest.rewardTask.multiplemax");
         _number.visible = false;
         _multipleX.visible = false;
         _multiplemax.visible = false;
         _multiplemax.smoothing = true;
         _multipleX.smoothing = true;
         addChild(_multipleX);
         addChild(_number);
         addChild(_multiplemax);
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc1_.removeEventListener(RewardSelectedEvent.ITEM_SELECTED,__chooseItemReward);
            _loc1_.dispose();
         }
         _items = null;
         ObjectUtils.disposeObject(_list);
         if(_improveBtn)
         {
            ObjectUtils.disposeObject(_improveBtn);
         }
         _improveBtn = null;
         if(_multipleX)
         {
            ObjectUtils.disposeObject(_multipleX);
         }
         _multipleX = null;
         if(_number)
         {
            ObjectUtils.disposeObject(_number);
         }
         _number = null;
         if(_multiplemax)
         {
            ObjectUtils.disposeObject(_multiplemax);
         }
         _multiplemax = null;
         _list = null;
         super.dispose();
      }
   }
}
