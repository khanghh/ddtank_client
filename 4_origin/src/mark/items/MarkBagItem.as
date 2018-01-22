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
      
      private function clickHandler(param1:InteractiveEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
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
               _loc2_ = MarkMgr.inst.model.sellList.indexOf(_id);
               if(_loc2_ > -1)
               {
                  MarkMgr.inst.model.sellList.splice(_loc2_,1);
               }
            }
            MarkMgr.inst.dispatchEvent(new MarkEvent("sellStatus"));
         }
         else
         {
            imgStatus.visible = false;
            _loc3_ = new MarkBagMenu(_id);
            _loc3_.x = parent.x + x + _cell.x + _cell.width - 8;
            _loc3_.y = parent.y + y + _cell.y + _cell.height - 10;
            parent.parent.addChild(_loc3_);
         }
         param1.stopImmediatePropagation();
      }
      
      public function set data(param1:MarkChipData) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc4_:int = 0;
         this.tipData = param1;
         var _loc9_:* = param1 != null;
         this.mouseEnabled = _loc9_;
         this.mouseChildren = _loc9_;
         var _loc2_:Array = ["",conStars1,conStars2,conStars3,conStars4,conStars5];
         var _loc3_:Array = ["",[clipStar11],[clipStar21,clipStar22],[clipStar31,clipStar32,clipStar33],[clipStar41,clipStar42,clipStar43,clipStar44],[clipStar51,clipStar52,clipStar53,clipStar54,clipStar55]];
         if(!param1)
         {
            if(_cell)
            {
               _cell.info = null;
            }
            _loc6_ = 1;
            while(_loc6_ < _loc2_.length)
            {
               _loc2_[_loc6_].visible = false;
               _loc6_++;
            }
            imgStatus.visible = false;
            return;
         }
         _id = param1.itemID;
         imgStatus.visible = MarkMgr.inst.model.sellList && MarkMgr.inst.model.sellList.indexOf(_id) > -1;
         if(!_cell)
         {
            _loc5_ = new Shape();
            _loc5_.graphics.beginFill(16777215,0);
            _loc5_.graphics.drawRect(0,0,56,56);
            _loc5_.graphics.endFill();
            _cell = new BaseCell(_loc5_);
            _cell.setContentSize(46,46);
            itemBox.addChild(_cell);
            _cell.addEventListener("interactive_click",clickHandler);
            _cell.addEventListener("interactive_double_click",doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(_cell);
         }
         _cell.info = ItemManager.Instance.getTemplateById(param1.templateId);
         _cell.tipData = null;
         _loc8_ = 1;
         while(_loc8_ < _loc2_.length)
         {
            if(_loc8_ == param1.bornLv + param1.hammerLv)
            {
               _loc2_[_loc8_].visible = true;
               _loc7_ = _loc3_[_loc8_];
               _loc4_ = 0;
               while(_loc4_ < _loc7_.length)
               {
                  _loc7_[_loc4_].index = _loc4_ < param1.bornLv?0:1;
                  _loc4_++;
               }
            }
            else
            {
               _loc2_[_loc8_].visible = false;
            }
            _loc8_++;
         }
      }
      
      protected function doubleClickHandler(param1:InteractiveEvent) : void
      {
         if(!MarkMgr.inst.model.sellStatus)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            MarkMgr.inst.moveChip(_id);
            param1.stopImmediatePropagation();
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
