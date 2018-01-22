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
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.tip"));
         _loc1_.submitLabel = LanguageMgr.GetTranslation("ok");
         _loc1_.moveEnable = false;
         info = _loc1_;
         _first = true;
         _items = new Vector.<QuestRewardCell>();
         addEventListener("response",__confirmResponse);
         initView();
      }
      
      public function set spand(param1:int) : void
      {
         _spand = param1;
         _textField.htmlText = LanguageMgr.GetTranslation("tank.manager.TaskManager.improveText",_spand);
      }
      
      public function set isOptional(param1:Boolean) : void
      {
         _isOptional = param1;
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
      
      public function set questInfo(param1:QuestInfo) : void
      {
         var _loc6_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         _questInfo = param1;
         var _loc8_:int = 0;
         var _loc7_:* = _questInfo.itemRewards;
         for each(var _loc5_ in _questInfo.itemRewards)
         {
            _loc6_ = new InventoryItemInfo();
            _loc6_.TemplateID = _loc5_.itemID;
            ItemManager.fill(_loc6_);
            _loc6_.ValidDate = _loc5_.ValidateTime;
            _loc6_.IsJudge = true;
            _loc6_.IsBinds = _loc5_.isBind;
            _loc6_.AttackCompose = _loc5_.AttackCompose;
            _loc6_.DefendCompose = _loc5_.DefendCompose;
            _loc6_.AgilityCompose = _loc5_.AgilityCompose;
            _loc6_.LuckCompose = _loc5_.LuckCompose;
            _loc6_.StrengthenLevel = _loc5_.StrengthenLevel;
            if(EquipType.isMagicStone(_loc6_.CategoryID))
            {
               _loc6_.Level = _loc6_.StrengthenLevel;
               _loc6_.Attack = _loc6_.AttackCompose;
               _loc6_.Defence = _loc6_.DefendCompose;
               _loc6_.Agility = _loc6_.AgilityCompose;
               _loc6_.Luck = _loc6_.LuckCompose;
               _loc6_.MagicAttack = _loc5_.MagicAttack;
               _loc6_.MagicDefence = _loc5_.MagicDefence;
            }
            if(_questInfo.QuestLevel > 4)
            {
               _loc3_ = 4;
            }
            else
            {
               _loc3_ = _questInfo.QuestLevel;
            }
            _loc6_.Count = _loc5_.count[_loc3_];
            if(!(0 != _loc6_.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != _loc6_.NeedSex))
            {
               if(_loc5_.isOptional == _isOptional)
               {
                  _loc4_ = new QuestRewardCell();
                  _loc4_.info = _loc6_;
                  if(_loc5_.isOptional)
                  {
                     _loc4_.canBeSelected();
                  }
                  _list.addChild(_loc4_);
                  _items.push(_loc4_);
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
         var _loc2_:int = 0;
         if(_questInfo.RewardGP > 0)
         {
            addReward("exp",_questInfo.RewardGP,_loc2_);
            _loc2_++;
         }
         if(_questInfo.RewardGold > 0)
         {
            addReward("gold",_questInfo.RewardGold,_loc2_);
            _loc2_++;
         }
         if(_questInfo.RewardMoney > 0)
         {
            addReward("coin",_questInfo.RewardMoney,_loc2_);
            _loc2_++;
         }
         if(_questInfo.RewardOffer > 0)
         {
            addReward("honor",_questInfo.RewardOffer,_loc2_);
            _loc2_++;
         }
         if(_questInfo.RewardRiches > 0)
         {
            addReward("rich",_questInfo.RewardRiches,_loc2_);
            _loc2_++;
         }
         if(_questInfo.RewardBindMoney > 0)
         {
            addReward("gift",_questInfo.RewardBindMoney,_loc2_);
            _loc2_++;
         }
         if(_questInfo.Rank != "")
         {
            addReward("rank",0,_loc2_,true,_questInfo.Rank);
            _loc2_++;
         }
         _textField.x = (_contian.width - _textField.width) / 2;
         _bg.height = _contian.height + 12;
         height = 180 + _contian.height;
         _selectItem.y = _contian.y + 15 + _contian.height;
      }
      
      private function getSexByInt(param1:Boolean) : int
      {
         return !!param1?1:2;
      }
      
      private function addReward(param1:String, param2:int, param3:int, param4:Boolean = false, param5:String = "") : void
      {
         var _loc7_:FilterFrameText = ComponentFactory.Instance.creat("core.quest.MCQuestRewardImprove");
         if(param3 > 2)
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
                              _loc7_.text = LanguageMgr.GetTranslation("consortion.skillFrame.richesText3");
                           }
                        }
                        else
                        {
                           _loc7_.text = LanguageMgr.GetTranslation("medalMoney");
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
         if(param3 == 0)
         {
            _loc7_.x = 5;
         }
         else if(param3 == 1)
         {
            _loc7_.x = param3 % 3 * 127 + 18;
         }
         else
         {
            _loc7_.x = param3 % 3 * 100 + 18;
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
         _contian.addChild(_loc7_);
         _contian.addChild(_loc6_);
         _selectItem.y = _contian.y + 7 + _bg.height;
      }
      
      private function __confirmResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
