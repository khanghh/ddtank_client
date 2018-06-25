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
   import ddt.manager.SoundManager;
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
         var i:int = 0;
         _rankCombo = ComponentFactory.Instance.creatComponentByStylename("mark.rank");
         addChild(_rankCombo);
         _rankCombo.beginChanges();
         _rankCombo.listPanel.vectorListModel.clear();
         var rankStrs:Array = [LanguageMgr.GetTranslation("mark.defaultRank"),LanguageMgr.GetTranslation("mark.starLvRank"),LanguageMgr.GetTranslation("mark.characterRank")];
         for(i = 0; i < rankStrs.length; )
         {
            _rankCombo.listPanel.vectorListModel.append(rankStrs[i]);
            i++;
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
      
      private function cancelSell(evt:MarkEvent) : void
      {
         var i:int = 0;
         MarkMgr.inst.model.sellList.length = 0;
         btnSell.disabled = true;
         var item:MarkBagItem = null;
         i = listBag.startIndex;
         while(listBag.array && i < listBag.array.length)
         {
            item = listBag.getCell(i) as MarkBagItem;
            item.imgStatus.visible = false;
            i++;
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
      
      private function updateSellStatus(evt:MarkEvent = null) : void
      {
         btnSell.disabled = MarkMgr.inst.model.sellList == null || MarkMgr.inst.model.sellList.length == 0;
      }
      
      private function help() : void
      {
         if(_setId < 0)
         {
            return;
         }
         var frame:MarkHelpView = new MarkHelpView();
         PositionUtils.setPos(frame,{
            "x":280,
            "y":76
         });
         frame.data = sortedSuits;
         LayerManager.Instance.addToLayer(frame,3,false,1);
      }
      
      private function get sortedSuits() : Array
      {
         var arr:Array = [];
         arr.push(MarkMgr.inst.model.cfgSet[_setId]);
         var _loc4_:int = 0;
         var _loc3_:* = MarkMgr.inst.model.cfgSet;
         for each(var it in MarkMgr.inst.model.cfgSet)
         {
            if(it.SetId != _setId)
            {
               arr.push(it);
            }
         }
         return arr;
      }
      
      private function itemClickHander(event:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         _rankType = event.index;
         sort();
      }
      
      private function sort() : void
      {
         if(!listBag.array)
         {
            return;
         }
         var tmp:Array = listBag.array.sort(function(left:MarkChipData, right:MarkChipData):int
         {
            var l:MarkChipTemplateData = MarkMgr.inst.model.cfgChip[left.templateId];
            var r:MarkChipTemplateData = MarkMgr.inst.model.cfgChip[right.templateId];
            if(_rankType == 0)
            {
               if(l.Place < r.Place)
               {
                  return -1;
               }
               if(l.Place == r.Place)
               {
                  if(l.Character < r.Character)
                  {
                     return -1;
                  }
                  if(l.Character == r.Character)
                  {
                     if(left.bornLv + left.hammerLv < right.bornLv + right.hammerLv)
                     {
                        return 1;
                     }
                     if(left.bornLv + left.hammerLv == right.bornLv + right.hammerLv)
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
               if(left.bornLv + left.hammerLv < right.bornLv + right.hammerLv)
               {
                  return 1;
               }
               if(left.bornLv + left.hammerLv == right.bornLv + right.hammerLv)
               {
                  if(l.Character == r.Character)
                  {
                     if(l.Place < r.Place)
                     {
                        return -1;
                     }
                     if(l.Place == r.Place)
                     {
                        return 0;
                     }
                     return 1;
                  }
                  if(l.Character < r.Character)
                  {
                     return 1;
                  }
                  return -1;
               }
               return -1;
            }
            if(_rankType == 2)
            {
               if(l.Character == r.Character)
               {
                  if(left.bornLv + left.hammerLv < right.bornLv + right.hammerLv)
                  {
                     return 1;
                  }
                  if(left.bornLv + left.hammerLv == right.bornLv + right.hammerLv)
                  {
                     if(l.Place < r.Place)
                     {
                        return -1;
                     }
                     if(l.Place == r.Place)
                     {
                        return 0;
                     }
                     return 1;
                  }
                  return -1;
               }
               if(l.Character < r.Character)
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
         var i:int = 0;
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
         var item:MarkBagItem = null;
         i = listBag.startIndex;
         while(listBag.array && i < listBag.array.length)
         {
            item = listBag.getCell(i) as MarkBagItem;
            item.imgStatus.visible = false;
            i++;
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
      
      private function __onBlackGoundMouseDown(event:MouseEvent) : void
      {
         event.stopImmediatePropagation();
      }
      
      private function sell() : void
      {
         MarkMgr.inst.submitSell();
      }
      
      private function render(item:MarkBagItem, index:int) : void
      {
         if(index < listBag.array.length)
         {
            item.data = listBag.array[index];
         }
         else if(index < 4 * 7 || (listBag.array.length % 4 + 1) * 7)
         {
            item.data = null;
         }
      }
      
      public function set data(value:MarkBagData) : void
      {
         lblName.text = MarkMgr.inst.model.cfgSet[value.type].Name;
         _setId = value.type;
         listBag.array = [];
         var _loc4_:int = 0;
         var _loc3_:* = value.chips;
         for each(var chip in value.chips)
         {
            listBag.array.push(chip);
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
