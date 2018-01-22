package mark.views
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mark.MarkMgr;
   import mark.data.MarkBagData;
   import mark.data.MarkChipData;
   import mark.data.MarkChipTemplateData;
   import mark.data.MarkSetTemplateData;
   import mark.event.MarkEvent;
   import mark.items.MarkBagItem;
   import mark.mornUI.views.MarkBagViewUI;
   import morn.core.handlers.Handler;
   
   public class MarkBagView extends MarkBagViewUI
   {
      
      private static const _ROW:int = 4;
      
      private static const _CLOUMN:int = 7;
       
      
      private var _blackGound:Sprite = null;
      
      private var _rankCombo:ComboBox = null;
      
      private var _setId:int = -1;
      
      private var _rankType:int = 0;
      
      public function MarkBagView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         _rankCombo = ComponentFactory.Instance.creatComponentByStylename("mark.rank");
         addChild(_rankCombo);
         _rankCombo.beginChanges();
         _rankCombo.listPanel.vectorListModel.clear();
         var _loc1_:Array = [LanguageMgr.GetTranslation("mark.defaultRank"),LanguageMgr.GetTranslation("mark.starLvRank"),LanguageMgr.GetTranslation("mark.characterRank")];
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _rankCombo.listPanel.vectorListModel.append(_loc1_[_loc2_]);
            _loc2_++;
         }
         _rankCombo.commitChanges();
         initEvent();
         _rankCombo.currentSelectedIndex = 0;
         listBag.renderHandler = new Handler(render);
         btnSell.visible = false;
         btnSelectSell.visible = true;
         btnCancel.visible = false;
         btnReturn.visible = true;
         btnSell.clickHandler = new Handler(sell);
         btnSelectSell.clickHandler = new Handler(choose);
         btnCancel.clickHandler = new Handler(cancel);
         btnReturn.clickHandler = new Handler(goBack);
         btnHelp.clickHandler = new Handler(help);
         updateSellStatus();
      }
      
      private function initEvent() : void
      {
         MarkMgr.inst.addEventListener("sellStatus",updateSellStatus);
         MarkMgr.inst.addEventListener("cancelSell",cancelSell);
         _rankCombo.listPanel.list.addEventListener("listItemClick",itemClickHander);
      }
      
      private function cancelSell(param1:MarkEvent) : void
      {
         var _loc3_:int = 0;
         MarkMgr.inst.model.sellList.length = 0;
         btnSell.disabled = true;
         var _loc2_:MarkBagItem = null;
         _loc3_ = listBag.startIndex;
         while(listBag.array && _loc3_ < listBag.array.length)
         {
            _loc2_ = listBag.getCell(_loc3_) as MarkBagItem;
            _loc2_.imgStatus.visible = false;
            _loc3_++;
         }
      }
      
      private function removeEvent() : void
      {
         MarkMgr.inst.removeEventListener("sellStatus",updateSellStatus);
         MarkMgr.inst.removeEventListener("cancelSell",cancelSell);
         if(_rankCombo)
         {
            _rankCombo.listPanel.list.removeEventListener("listItemClick",itemClickHander);
         }
      }
      
      private function updateSellStatus(param1:MarkEvent = null) : void
      {
         btnSell.disabled = MarkMgr.inst.model.sellList == null || MarkMgr.inst.model.sellList.length == 0;
      }
      
      private function help() : void
      {
         if(_setId < 0)
         {
            return;
         }
         var _loc1_:MarkHelpView = new MarkHelpView();
         PositionUtils.setPos(_loc1_,{
            "x":280,
            "y":76
         });
         _loc1_.data = sortedSuits;
         LayerManager.Instance.addToLayer(_loc1_,3,false,1);
      }
      
      private function get sortedSuits() : Array
      {
         var _loc2_:Array = [];
         _loc2_.push(MarkMgr.inst.model.cfgSet[_setId]);
         var _loc4_:int = 0;
         var _loc3_:* = MarkMgr.inst.model.cfgSet;
         for each(var _loc1_ in MarkMgr.inst.model.cfgSet)
         {
            if(_loc1_.SetId != _setId)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      private function itemClickHander(param1:ListItemEvent) : void
      {
         _rankType = param1.index;
         sort();
      }
      
      private function sort() : void
      {
         if(!listBag.array)
         {
            return;
         }
         var tmp:Array = listBag.array.sort(function(param1:MarkChipData, param2:MarkChipData):int
         {
            var _loc4_:MarkChipTemplateData = MarkMgr.inst.model.cfgChip[param1.templateId];
            var _loc3_:MarkChipTemplateData = MarkMgr.inst.model.cfgChip[param2.templateId];
            if(_rankType == 0)
            {
               if(_loc4_.Place < _loc3_.Place)
               {
                  return -1;
               }
               if(_loc4_.Place == _loc3_.Place)
               {
                  if(_loc4_.Character < _loc3_.Character)
                  {
                     return -1;
                  }
                  if(_loc4_.Character == _loc3_.Character)
                  {
                     if(param1.bornLv + param1.hammerLv < param2.bornLv + param2.hammerLv)
                     {
                        return 1;
                     }
                     if(param1.bornLv + param1.hammerLv == param2.bornLv + param2.hammerLv)
                     {
                        return 0;
                     }
                     return -1;
                  }
                  return 1;
               }
               return 1;
            }
            if(_rankType == 1)
            {
               if(param1.bornLv + param1.hammerLv < param2.bornLv + param2.hammerLv)
               {
                  return 1;
               }
               if(param1.bornLv + param1.hammerLv == param2.bornLv + param2.hammerLv)
               {
                  if(_loc4_.Character == _loc3_.Character)
                  {
                     if(_loc4_.Place < _loc3_.Place)
                     {
                        return -1;
                     }
                     if(_loc4_.Place == _loc3_.Place)
                     {
                        return 0;
                     }
                     return 1;
                  }
                  if(_loc4_.Character < _loc3_.Character)
                  {
                     return 1;
                  }
                  return -1;
               }
               return -1;
            }
            if(_rankType == 2)
            {
               if(_loc4_.Character == _loc3_.Character)
               {
                  if(param1.bornLv + param1.hammerLv < param2.bornLv + param2.hammerLv)
                  {
                     return 1;
                  }
                  if(param1.bornLv + param1.hammerLv == param2.bornLv + param2.hammerLv)
                  {
                     if(_loc4_.Place < _loc3_.Place)
                     {
                        return -1;
                     }
                     if(_loc4_.Place == _loc3_.Place)
                     {
                        return 0;
                     }
                     return 1;
                  }
                  return -1;
               }
               if(_loc4_.Character < _loc3_.Character)
               {
                  return 1;
               }
               return -1;
            }
         });
         listBag.array = tmp;
      }
      
      private function goBack() : void
      {
         if(_blackGound)
         {
            _blackGound.visible = false;
         }
         this.visible = false;
      }
      
      private function cancel() : void
      {
         var _loc2_:int = 0;
         if(_blackGound)
         {
            _blackGound.visible = false;
         }
         MarkMgr.inst.model.sellStatus = false;
         btnSell.visible = false;
         btnSelectSell.visible = true;
         btnCancel.visible = false;
         btnReturn.visible = true;
         MarkMgr.inst.model.sellList.length = 0;
         var _loc1_:MarkBagItem = null;
         _loc2_ = listBag.startIndex;
         while(listBag.array && _loc2_ < listBag.array.length)
         {
            _loc1_ = listBag.getCell(_loc2_) as MarkBagItem;
            _loc1_.imgStatus.visible = false;
            _loc2_++;
         }
      }
      
      private function choose() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!_blackGound)
         {
            _blackGound = new Sprite();
            _blackGound.graphics.beginFill(0,0.4);
            _blackGound.graphics.drawRect(-3000,-3000,6000,6000);
            _blackGound.graphics.endFill();
            _blackGound.addEventListener("mouseDown",__onBlackGoundMouseDown);
            parent.addChild(_blackGound);
            parent.swapChildren(this,_blackGound);
         }
         else
         {
            _blackGound.visible = true;
         }
         MarkMgr.inst.model.sellStatus = true;
         btnSell.visible = true;
         btnSelectSell.visible = false;
         btnCancel.visible = true;
         btnReturn.visible = false;
      }
      
      private function __onBlackGoundMouseDown(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
      }
      
      private function sell() : void
      {
         MarkMgr.inst.submitSell();
      }
      
      private function render(param1:MarkBagItem, param2:int) : void
      {
         if(param2 < listBag.array.length)
         {
            param1.data = listBag.array[param2];
         }
         else if(param2 < 4 * 7 || (listBag.array.length % 4 + 1) * 7)
         {
            param1.data = null;
         }
      }
      
      public function set data(param1:MarkBagData) : void
      {
         lblName.text = MarkMgr.inst.model.cfgSet[param1.type].Name;
         _setId = param1.type;
         listBag.array = [];
         var _loc4_:int = 0;
         var _loc3_:* = param1.chips;
         for each(var _loc2_ in param1.chips)
         {
            listBag.array.push(_loc2_);
         }
         btnSelectSell.disabled = listBag.array == null || listBag.array.length == 0;
         sort();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_blackGound)
         {
            _blackGound.addEventListener("mouseDown",__onBlackGoundMouseDown);
            ObjectUtils.disposeObject(_blackGound);
            _blackGound = null;
         }
         if(_rankCombo)
         {
            _rankCombo.listPanel.list.removeEventListener("listItemClick",itemClickHander);
            ObjectUtils.disposeObject(_rankCombo);
            _rankCombo = null;
         }
         MarkMgr.inst.removeEventListener("sellStatus",updateSellStatus);
         MarkMgr.inst.model.sellStatus = false;
         super.dispose();
      }
   }
}
