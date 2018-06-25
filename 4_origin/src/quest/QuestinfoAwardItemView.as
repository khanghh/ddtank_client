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
      
      public function QuestinfoAwardItemView(isOptional:Boolean)
      {
         _isOptional = isOptional;
         _first = true;
         _items = new Vector.<QuestRewardCell>();
         super();
      }
      
      public function set isReward(value:Boolean) : void
      {
         _isReward = value;
      }
      
      override public function set info(value:QuestInfo) : void
      {
         var tinfo:* = null;
         var item:* = null;
         var buffTime:int = 0;
         var valueTxt:* = null;
         _info = value;
         var _loc10_:int = 0;
         var _loc9_:* = _info.itemRewards;
         for each(var temp in _info.itemRewards)
         {
            tinfo = new InventoryItemInfo();
            tinfo.TemplateID = temp.itemID;
            ItemManager.fill(tinfo);
            tinfo.ValidDate = temp.ValidateTime;
            tinfo.IsJudge = true;
            tinfo.IsBinds = temp.isBind;
            tinfo.AttackCompose = temp.AttackCompose;
            tinfo.DefendCompose = temp.DefendCompose;
            tinfo.AgilityCompose = temp.AgilityCompose;
            tinfo.LuckCompose = temp.LuckCompose;
            tinfo.StrengthenLevel = temp.StrengthenLevel;
            tinfo.Count = temp.count[_info.QuestLevel - 1];
            if(EquipType.isMagicStone(tinfo.CategoryID))
            {
               tinfo.Level = tinfo.StrengthenLevel;
               tinfo.Attack = tinfo.AttackCompose;
               tinfo.Defence = tinfo.DefendCompose;
               tinfo.Agility = tinfo.AgilityCompose;
               tinfo.Luck = tinfo.LuckCompose;
               tinfo.MagicAttack = temp.MagicAttack;
               tinfo.MagicDefence = temp.MagicDefence;
            }
            if(!(0 != tinfo.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != tinfo.NeedSex))
            {
               if(temp.isOptional == _isOptional)
               {
                  item = new QuestRewardCell();
                  item.info = tinfo;
                  if(temp.isOptional)
                  {
                     item.canBeSelected();
                     item.addEventListener(RewardSelectedEvent.ITEM_SELECTED,__chooseItemReward);
                  }
                  _list.addChild(item);
                  _items.push(item);
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
         var index:int = 0;
         var realnfo:QuestInfo = newInfo(_info,_info.QuestLevel - 2,TaskManager.instance.improve);
         if(realnfo.RewardGP > 0)
         {
            addReward("exp",realnfo.RewardGP,index);
            index++;
         }
         if(realnfo.RewardGold > 0)
         {
            addReward("gold",realnfo.RewardGold,index);
            index++;
         }
         if(realnfo.RewardMoney > 0)
         {
            addReward("coin",realnfo.RewardMoney,index);
            index++;
         }
         if(realnfo.RewardOffer > 0)
         {
            addReward("honor",realnfo.RewardOffer,index);
            index++;
         }
         if(_info.RewardRiches > 0)
         {
            addReward("rich",_info.RewardRiches,index);
            index++;
         }
         if(_info.RewardBindMoney > 0)
         {
            addReward("gift",_info.RewardBindMoney,index);
            index++;
         }
         if(_info.Rank != "")
         {
            addReward("rank",0,index,true,_info.Rank);
            index++;
         }
         if(_info.RewardBuffID != 0)
         {
            cardAsset = ComponentFactory.Instance.creat("core.quest.MCQuestRewardBuff");
            addChild(cardAsset);
            cardAsset.setFrame(_info.RewardBuffID - 11994);
            buffTime = _info.RewardBuffDate;
            valueTxt = ComponentFactory.Instance.creat("core.quest.QuestItemRewardQuantity");
            addChild(valueTxt);
            valueTxt.x = cardAsset.x + cardAsset.width + 2;
            valueTxt.y = cardAsset.y;
            valueTxt.text = String(buffTime) + LanguageMgr.GetTranslation("hours");
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
      
      private function getNeedMoney(pInfo:QuestInfo) : int
      {
         if(pInfo.QuestLevel == 1)
         {
            return pInfo.Level2NeedMoney;
         }
         if(pInfo.QuestLevel == 2)
         {
            return pInfo.Level3NeedMoney;
         }
         if(pInfo.QuestLevel == 3)
         {
            return pInfo.Level4NeedMoney;
         }
         if(pInfo.QuestLevel == 4)
         {
            return pInfo.Level5NeedMoney;
         }
         return -1;
      }
      
      private function newInfo(pInfo:QuestInfo, level:int, info:QuestImproveInfo) : QuestInfo
      {
         var vInfo:* = null;
         if(level > -1)
         {
            vInfo = new QuestInfo();
            vInfo.RewardMoney = info.bindMoneyRate[level] * pInfo.RewardMoney;
            vInfo.RewardGP = info.expRate[level] * pInfo.RewardGP;
            vInfo.RewardGold = info.goldRate[level] * pInfo.RewardGold;
            vInfo.RewardOffer = info.exploitRate[level] * pInfo.RewardOffer;
            return vInfo;
         }
         return pInfo;
      }
      
      private function _activeimproveBtnClick(event:MouseEvent) : void
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
      
      private function getImproveInfo(info:QuestImproveInfo, level:int) : QuestInfo
      {
         var questInfo:QuestInfo = new QuestInfo();
         ObjectUtils.copyProperties(questInfo,_info);
         questInfo.data = _info.data;
         questInfo.RewardMoney = questInfo.RewardMoney * info.bindMoneyRate[level];
         questInfo.RewardGP = questInfo.RewardGP * info.expRate[level];
         questInfo.RewardGold = questInfo.RewardGold * info.goldRate[level];
         questInfo.RewardOffer = questInfo.RewardOffer * info.exploitRate[level];
         var _loc6_:int = 0;
         var _loc5_:* = _info.itemRewards;
         for each(var reward in _info.itemRewards)
         {
            questInfo.addReward(reward);
         }
         return questInfo;
      }
      
      private function __chooseItemReward(evt:RewardSelectedEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var cell in _items)
         {
            cell.selected = false;
         }
         evt.itemCell.selected = true;
      }
      
      private function getSexByInt(Sex:Boolean) : int
      {
         return !!Sex?1:2;
      }
      
      private function addReward(reward:String, count:int, index:int, isRank:Boolean = false, rank:String = "") : void
      {
         var rewardMC:FilterFrameText = ComponentFactory.Instance.creat("core.quest.MCQuestRewardType");
         if(index > 3)
         {
            rewardMC.y = rewardMC.y + 20;
            if(_first)
            {
               _list.y = _list.y + 20;
               _first = false;
            }
         }
         var quantityTxt:FilterFrameText = ComponentFactory.Instance.creat("core.quest.QuestItemRewardQuantity");
         var _loc8_:* = reward;
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
                                    rewardMC.text = LanguageMgr.GetTranslation("tank.view.effort.EffortRigthItemView.honorNameII");
                                 }
                              }
                              else
                              {
                                 rewardMC.text = LanguageMgr.GetTranslation("gift");
                              }
                           }
                           else
                           {
                              rewardMC.text = LanguageMgr.GetTranslation("medalMoney");
                           }
                        }
                        else
                        {
                           rewardMC.text = LanguageMgr.GetTranslation("ddtMoney");
                        }
                     }
                     else
                     {
                        rewardMC.text = StringUtils.trim(LanguageMgr.GetTranslation("gongxun"));
                     }
                  }
                  else
                  {
                     rewardMC.text = LanguageMgr.GetTranslation("consortia.Money");
                  }
               }
               else
               {
                  rewardMC.text = LanguageMgr.GetTranslation("money");
               }
            }
            else
            {
               rewardMC.text = LanguageMgr.GetTranslation("gold");
            }
         }
         else
         {
            rewardMC.text = LanguageMgr.GetTranslation("exp");
         }
         if(index < 2)
         {
            rewardMC.x = index % 4 * 135 + 18;
         }
         else
         {
            rewardMC.x = index % 4 * 110 + 18;
         }
         quantityTxt.x = rewardMC.x + rewardMC.textWidth + 5;
         quantityTxt.y = rewardMC.y;
         if(isRank)
         {
            quantityTxt.text = rank;
         }
         else
         {
            quantityTxt.text = String(count);
         }
         _content.addChildAt(rewardMC,0);
         _content.addChildAt(quantityTxt,0);
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
         for each(var item in _items)
         {
            item.removeEventListener(RewardSelectedEvent.ITEM_SELECTED,__chooseItemReward);
            item.dispose();
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
