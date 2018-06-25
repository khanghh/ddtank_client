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
         for each(var item in _items)
         {
            item.dispose();
         }
      }
      
      public function set info(value:QuestInfo) : void
      {
         var i:int = 0;
         var cond:* = null;
         var tinfo:* = null;
         var necessaryTarget:* = null;
         var notNecessaryTarget:* = null;
         var necessaryAward:* = null;
         var optionalAward:* = null;
         TaskManager.itemAwardSelected = 0;
         _isImprove = false;
         _info = value;
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
         var hasNeccesaryTarget:Boolean = false;
         var hasNotNeccessaryTarget:Boolean = false;
         var hasNecessaryAward:Boolean = false;
         var hasOptionalAward:Boolean = false;
         i = 0;
         while(_info.conditions[i])
         {
            cond = _info.conditions[i];
            if(!cond.isOpitional)
            {
               hasNeccesaryTarget = true;
            }
            else
            {
               hasNotNeccessaryTarget = true;
            }
            i++;
         }
         if(!hasNecessaryAward)
         {
            hasNecessaryAward = info.hasOtherAward();
         }
         var _loc17_:int = 0;
         var _loc16_:* = _info.itemRewards;
         for each(var temp in _info.itemRewards)
         {
            tinfo = new InventoryItemInfo();
            tinfo.TemplateID = temp.itemID;
            ItemManager.fill(tinfo);
            if(!(0 != tinfo.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != tinfo.NeedSex))
            {
               if(temp.isOptional == 0)
               {
                  hasNecessaryAward = true;
               }
               else if(temp.isOptional == 1)
               {
                  hasOptionalAward = true;
               }
            }
         }
         if(hasNeccesaryTarget)
         {
            necessaryTarget = new QuestinfoTargetItemView(false);
            necessaryTarget.isImprove = _isImprove;
            if(regressFlag)
            {
               necessaryTarget.setStarVipHide();
            }
            _items.push(necessaryTarget);
         }
         if(hasNotNeccessaryTarget)
         {
            notNecessaryTarget = new QuestinfoTargetItemView(true);
            if(regressFlag)
            {
               notNecessaryTarget.setStarVipHide();
            }
            _items.push(notNecessaryTarget);
         }
         if(hasNecessaryAward)
         {
            necessaryAward = new QuestinfoAwardItemView(false);
            necessaryAward.isReward = true;
            _items.push(necessaryAward);
         }
         if(hasOptionalAward)
         {
            optionalAward = new QuestinfoAwardItemView(true);
            TaskManager.itemAwardSelected = -1;
            _items.push(optionalAward);
         }
         var descriptionItem:QuestinfoDescriptionItemView = new QuestinfoDescriptionItemView();
         _items.push(descriptionItem);
         var _loc19_:int = 0;
         var _loc18_:* = _items;
         for each(var item in _items)
         {
            item.info = _info;
            container.addChild(item);
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
      
      private function __onGoToConsortia(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         gotoCMoive.removeEventListener("click",__onGoToConsortia);
         StateManager.setState("consortia");
      }
      
      private function getSexByInt(Sex:Boolean) : int
      {
         return !!Sex?1:2;
      }
      
      public function canGotoConsortia(value:Boolean) : void
      {
         if(value)
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
         var i:int = 0;
         _info = null;
         if(gotoCMoive)
         {
            gotoCMoive.dispose();
            gotoCMoive = null;
         }
         i = 0;
         while(i < _items.length)
         {
            if(_items[i])
            {
               _items[i].dispose();
               _items[i] = null;
            }
            i++;
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
      
      public function set regressFlag(value:Boolean) : void
      {
         _regressFlag = value;
      }
   }
}
