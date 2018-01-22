package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.quest.QuestCondition;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class QuestInfoPanelView extends Sprite
   {
       
      
      private const CONDITION_HEIGHT:int = 32;
      
      private const CONDITION_Y:int = 0;
      
      private const PADDING_Y:int = 8;
      
      private var _info:QuestInfo;
      
      private var gotoCMoive:TextButton;
      
      private var container:VBox;
      
      private var panel:ScrollPanel;
      
      private var _extraFrame:Sprite;
      
      private var _items:Vector.<QuestInfoItemView>;
      
      private var _starLevel:int;
      
      private var _complete:Boolean;
      
      private var _isImprove:Boolean;
      
      private var _lastId:int;
      
      private var _regressFlag:Boolean = false;
      
      public function QuestInfoPanelView()
      {
         super();
         _items = new Vector.<QuestInfoItemView>();
         _isImprove = false;
         initView();
      }
      
      private function initView() : void
      {
         container = ComponentFactory.Instance.creatComponentByStylename("quest.questinfoPanelView.vbox");
         panel = ComponentFactory.Instance.creatComponentByStylename("core.quest.QuestInfoPanel");
         panel.setView(container);
         addChild(panel);
      }
      
      public function clearItems() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc1_.dispose();
         }
      }
      
      public function set info(param1:QuestInfo) : void
      {
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc9_:* = null;
         var _loc5_:* = null;
         var _loc14_:* = null;
         var _loc2_:* = null;
         var _loc13_:* = null;
         TaskManager.itemAwardSelected = 0;
         _isImprove = false;
         _info = param1;
         if(_starLevel != _info.QuestLevel)
         {
            _starLevel = _info.QuestLevel;
            if(_lastId == _info.QuestID)
            {
               _isImprove = true;
            }
         }
         _lastId = _info.QuestID;
         _complete = _info.isCompleted;
         clearItems();
         _items = new Vector.<QuestInfoItemView>();
         var _loc15_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc6_:Boolean = false;
         _loc8_ = 0;
         while(_info.conditions[_loc8_])
         {
            _loc7_ = _info.conditions[_loc8_];
            if(!_loc7_.isOpitional)
            {
               _loc15_ = true;
            }
            else
            {
               _loc3_ = true;
            }
            _loc8_++;
         }
         if(!_loc10_)
         {
            _loc10_ = info.hasOtherAward();
         }
         var _loc17_:int = 0;
         var _loc16_:* = _info.itemRewards;
         for each(var _loc12_ in _info.itemRewards)
         {
            _loc9_ = new InventoryItemInfo();
            _loc9_.TemplateID = _loc12_.itemID;
            ItemManager.fill(_loc9_);
            if(!(0 != _loc9_.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != _loc9_.NeedSex))
            {
               if(_loc12_.isOptional == 0)
               {
                  _loc10_ = true;
               }
               else if(_loc12_.isOptional == 1)
               {
                  _loc6_ = true;
               }
            }
         }
         if(_loc15_)
         {
            _loc5_ = new QuestinfoTargetItemView(false);
            _loc5_.isImprove = _isImprove;
            if(regressFlag)
            {
               _loc5_.setStarVipHide();
            }
            _items.push(_loc5_);
         }
         if(_loc3_)
         {
            _loc14_ = new QuestinfoTargetItemView(true);
            if(regressFlag)
            {
               _loc14_.setStarVipHide();
            }
            _items.push(_loc14_);
         }
         if(_loc10_)
         {
            _loc2_ = new QuestinfoAwardItemView(false);
            _loc2_.isReward = true;
            _items.push(_loc2_);
         }
         if(_loc6_)
         {
            _loc13_ = new QuestinfoAwardItemView(true);
            TaskManager.itemAwardSelected = -1;
            _items.push(_loc13_);
         }
         var _loc4_:QuestinfoDescriptionItemView = new QuestinfoDescriptionItemView();
         _items.push(_loc4_);
         var _loc19_:int = 0;
         var _loc18_:* = _items;
         for each(var _loc11_ in _items)
         {
            _loc11_.info = _info;
            container.addChild(_loc11_);
         }
         if(info.QuestID == 339)
         {
            canGotoConsortia(true);
         }
         else
         {
            canGotoConsortia(false);
         }
         panel.invalidateViewport();
         visible = true;
      }
      
      private function __onGoToConsortia(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         gotoCMoive.removeEventListener("click",__onGoToConsortia);
         StateManager.setState("consortia");
      }
      
      private function getSexByInt(param1:Boolean) : int
      {
         return !!param1?1:2;
      }
      
      public function canGotoConsortia(param1:Boolean) : void
      {
         if(param1)
         {
            if(gotoCMoive == null)
            {
               gotoCMoive = ComponentFactory.Instance.creatComponentByStylename("core.quest.GoToConsortiaBtn");
               gotoCMoive.text = LanguageMgr.GetTranslation("tank.manager.TaskManager.GoToConsortia");
               gotoCMoive.addEventListener("click",__onGoToConsortia);
               addChild(gotoCMoive);
            }
         }
         else if(gotoCMoive)
         {
            gotoCMoive.removeEventListener("click",__onGoToConsortia);
            removeChild(gotoCMoive);
            gotoCMoive = null;
         }
      }
      
      public function get info() : QuestInfo
      {
         return _info;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _info = null;
         if(gotoCMoive)
         {
            gotoCMoive.dispose();
            gotoCMoive = null;
         }
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            if(_items[_loc1_])
            {
               _items[_loc1_].dispose();
               _items[_loc1_] = null;
            }
            _loc1_++;
         }
         _items.length = 0;
         if(container)
         {
            container.dispose();
            container = null;
         }
         if(panel)
         {
            panel.dispose();
            panel = null;
         }
      }
      
      public function get regressFlag() : Boolean
      {
         return _regressFlag;
      }
      
      public function set regressFlag(param1:Boolean) : void
      {
         _regressFlag = param1;
      }
   }
}
