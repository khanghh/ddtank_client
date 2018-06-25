package mark.items
{
   import bagAndInfo.cell.BaseCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import flash.display.Shape;
   import mark.MarkMgr;
   import mark.data.MarkChipData;
   import mark.event.MarkEvent;
   import mark.mornUI.items.MarkBagItemUI;
   import mark.views.MarkBagMenu;
   
   public class MarkBagItem extends MarkBagItemUI
   {
       
      
      private var _cell:BaseCell = null;
      
      private var _id:int = -1;
      
      public function MarkBagItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         imgStatus.visible = false;
      }
      
      private function clickHandler(evt:InteractiveEvent) : void
      {
         var index:int = 0;
         var menu:* = null;
         if(_id < 0)
         {
            return;
         }
         if(MarkMgr.inst.model.sellStatus)
         {
            if(!imgStatus.visible)
            {
               if(MarkMgr.inst.model.getChipById(_id).bornLv > 3)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.choose.highStar.sell"));
               }
               imgStatus.visible = true;
               MarkMgr.inst.model.sellList.push(_id);
            }
            else
            {
               imgStatus.visible = false;
               index = MarkMgr.inst.model.sellList.indexOf(_id);
               if(index > -1)
               {
                  MarkMgr.inst.model.sellList.splice(index,1);
               }
            }
            MarkMgr.inst.dispatchEvent(new MarkEvent("sellStatus"));
         }
         else
         {
            imgStatus.visible = false;
            menu = new MarkBagMenu(_id);
            menu.x = parent.x + x + _cell.x + _cell.width - 8;
            menu.y = parent.y + y + _cell.y + _cell.height - 10;
            parent.parent.addChild(menu);
         }
         evt.stopImmediatePropagation();
      }
      
      public function set data(value:MarkChipData) : void
      {
         var k:int = 0;
         var cellBG:* = null;
         var i:int = 0;
         var starArr:* = null;
         var j:int = 0;
         this.tipData = value;
         var _loc9_:* = value != null;
         this.mouseEnabled = _loc9_;
         this.mouseChildren = _loc9_;
         var containers:Array = ["",conStars1,conStars2,conStars3,conStars4,conStars5];
         var stars:Array = ["",[clipStar11],[clipStar21,clipStar22],[clipStar31,clipStar32,clipStar33],[clipStar41,clipStar42,clipStar43,clipStar44],[clipStar51,clipStar52,clipStar53,clipStar54,clipStar55]];
         if(!value)
         {
            if(_cell)
            {
               _cell.info = null;
            }
            for(k = 1; k < containers.length; )
            {
               containers[k].visible = false;
               k++;
            }
            imgStatus.visible = false;
            return;
         }
         _id = value.itemID;
         imgStatus.visible = MarkMgr.inst.model.sellList && MarkMgr.inst.model.sellList.indexOf(_id) > -1;
         if(!_cell)
         {
            cellBG = new Shape();
            cellBG.graphics.beginFill(16777215,0);
            cellBG.graphics.drawRect(0,0,56,56);
            cellBG.graphics.endFill();
            _cell = new BaseCell(cellBG);
            _cell.setContentSize(46,46);
            itemBox.addChild(_cell);
            _cell.addEventListener("interactive_click",clickHandler);
            _cell.addEventListener("interactive_double_click",doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(_cell);
         }
         _cell.info = ItemManager.Instance.getTemplateById(value.templateId);
         _cell.tipData = value;
         for(i = 1; i < containers.length; )
         {
            if(i == value.bornLv + value.hammerLv)
            {
               containers[i].visible = true;
               starArr = stars[i];
               for(j = 0; j < starArr.length; )
               {
                  starArr[j].index = j < value.bornLv?0:1;
                  j++;
               }
            }
            else
            {
               containers[i].visible = false;
            }
            i++;
         }
      }
      
      protected function doubleClickHandler(evt:InteractiveEvent) : void
      {
         if(!MarkMgr.inst.model.sellStatus)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            MarkMgr.inst.moveChip(_id);
            evt.stopImmediatePropagation();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
            _cell.removeEventListener("interactive_click",clickHandler);
            _cell.removeEventListener("interactive_double_click",doubleClickHandler);
         }
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
