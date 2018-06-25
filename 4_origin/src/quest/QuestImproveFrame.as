package quest
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.DoubleSelectedItem;
   import flash.display.Sprite;
   
   public class QuestImproveFrame extends BaseAlerFrame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _textFieldStyle:String;
      
      protected var _textField:FilterFrameText;
      
      private var _contian:Sprite;
      
      private var _questInfo:QuestInfo;
      
      private var _isOptional:Boolean;
      
      private var _list:SimpleTileList;
      
      private var _items:Vector.<QuestRewardCell>;
      
      private var _spand:int;
      
      private var _selectItem:DoubleSelectedItem;
      
      private var _first:Boolean;
      
      public function QuestImproveFrame()
      {
         super();
         var alertInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.tip"));
         alertInfo.submitLabel = LanguageMgr.GetTranslation("ok");
         alertInfo.moveEnable = false;
         info = alertInfo;
         _first = true;
         _items = new Vector.<QuestRewardCell>();
         addEventListener("response",__confirmResponse);
         initView();
      }
      
      public function set spand(value:int) : void
      {
         _spand = value;
         _textField.htmlText = LanguageMgr.GetTranslation("tank.manager.TaskManager.improveText",_spand);
      }
      
      public function set isOptional(value:Boolean) : void
      {
         _isOptional = value;
      }
      
      private function initView() : void
      {
         _contian = new Sprite();
         _contian.y = 40;
         addToContent(_contian);
         _textField = ComponentFactory.Instance.creat("core.quest.QuestSpandText");
         addToContent(_textField);
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.questBack.bg");
         _contian.addChild(_bg);
         _list = new SimpleTileList(2);
         if(!_isOptional)
         {
            PositionUtils.setPos(_list,"quest.awardPanel.listposr");
         }
         else
         {
            PositionUtils.setPos(_list,"quest.awardPanel.listposr1");
         }
         _contian.addChild(_list);
         _selectItem = new DoubleSelectedItem();
         _selectItem.x = 162;
         _selectItem.y = _contian.y + 15 + _contian.height;
         addToContent(_selectItem);
      }
      
      public function set questInfo(value:QuestInfo) : void
      {
         var tinfo:* = null;
         var level:int = 0;
         var item:* = null;
         _questInfo = value;
         var _loc8_:int = 0;
         var _loc7_:* = _questInfo.itemRewards;
         for each(var temp in _questInfo.itemRewards)
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
            if(_questInfo.QuestLevel > 4)
            {
               level = 4;
            }
            else
            {
               level = _questInfo.QuestLevel;
            }
            tinfo.Count = temp.count[level];
            if(!(0 != tinfo.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != tinfo.NeedSex))
            {
               if(temp.isOptional == _isOptional)
               {
                  item = new QuestRewardCell();
                  item.info = tinfo;
                  if(temp.isOptional)
                  {
                     item.canBeSelected();
                  }
                  _list.addChild(item);
                  _items.push(item);
               }
            }
         }
         if(_isOptional)
         {
            return;
         }
         if(!_questInfo.hasOtherAward())
         {
            _list.y = 5;
         }
         var index:int = 0;
         if(_questInfo.RewardGP > 0)
         {
            addReward("exp",_questInfo.RewardGP,index);
            index++;
         }
         if(_questInfo.RewardGold > 0)
         {
            addReward("gold",_questInfo.RewardGold,index);
            index++;
         }
         if(_questInfo.RewardMoney > 0)
         {
            addReward("coin",_questInfo.RewardMoney,index);
            index++;
         }
         if(_questInfo.RewardOffer > 0)
         {
            addReward("honor",_questInfo.RewardOffer,index);
            index++;
         }
         if(_questInfo.RewardRiches > 0)
         {
            addReward("rich",_questInfo.RewardRiches,index);
            index++;
         }
         if(_questInfo.RewardBindMoney > 0)
         {
            addReward("gift",_questInfo.RewardBindMoney,index);
            index++;
         }
         if(_questInfo.Rank != "")
         {
            addReward("rank",0,index,true,_questInfo.Rank);
            index++;
         }
         _textField.x = (_contian.width - _textField.width) / 2;
         _bg.height = _contian.height + 12;
         height = 180 + _contian.height;
         _selectItem.y = _contian.y + 15 + _contian.height;
      }
      
      private function getSexByInt(Sex:Boolean) : int
      {
         return !!Sex?1:2;
      }
      
      private function addReward(reward:String, count:int, index:int, isRank:Boolean = false, rank:String = "") : void
      {
         var rewardMC:FilterFrameText = ComponentFactory.Instance.creat("core.quest.MCQuestRewardImprove");
         if(index > 2)
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
                              rewardMC.text = LanguageMgr.GetTranslation("consortion.skillFrame.richesText3");
                           }
                        }
                        else
                        {
                           rewardMC.text = LanguageMgr.GetTranslation("medalMoney");
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
         if(index == 0)
         {
            rewardMC.x = 5;
         }
         else if(index == 1)
         {
            rewardMC.x = index % 3 * 127 + 18;
         }
         else
         {
            rewardMC.x = index % 3 * 100 + 18;
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
         _contian.addChild(rewardMC);
         _contian.addChild(quantityTxt);
         _selectItem.y = _contian.y + 7 + _bg.height;
      }
      
      private function __confirmResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               break;
            case 2:
            case 3:
            case 4:
               CheckMoneyUtils.instance.checkMoney(_selectItem.isBind,_spand,onCheckComplete);
         }
         removeEventListener("response",__confirmResponse);
         dispose();
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendImproveQuest(_questInfo.id,CheckMoneyUtils.instance.isBind);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_selectItem);
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         ObjectUtils.disposeObject(_textField);
         _textField = null;
         if(_contian)
         {
            ObjectUtils.disposeObject(_contian);
         }
         _contian = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         super.dispose();
      }
   }
}
