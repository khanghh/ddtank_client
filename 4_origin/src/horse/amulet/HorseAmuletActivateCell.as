package horse.amulet
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Shape;
   import flash.utils.Dictionary;
   import horse.HorseAmuletManager;
   import horse.data.HorseAmuletVo;
   
   public class HorseAmuletActivateCell extends HorseAmuletCell
   {
       
      
      private var _bag:BagInfo;
      
      private var _alertFrame:BaseAlerFrame;
      
      private var _oldPlace:int;
      
      private var _newPlace:int;
      
      public function HorseAmuletActivateCell()
      {
         super(19,null,createBg());
         init();
      }
      
      private function init() : void
      {
         _bag = PlayerManager.Instance.Self.getBag(42);
         this.info = _bag.getItemAt(19);
         this.addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
         _bag.addEventListener("update",__updateGoods);
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var info:* = null;
         var vo:* = null;
         if(effect && effect.action == "move" && effect.data)
         {
            info = effect.data as InventoryItemInfo;
            if(effect.source is HorseAmuletCell)
            {
               vo = HorseAmuletManager.instance.getHorseAmuletVo((effect.source as HorseAmuletCell).itemInfo.TemplateID);
               if(vo.IsCanWash)
               {
                  _oldPlace = (effect.source as HorseAmuletCell).place;
                  _newPlace = 19;
                  if(HorseAmuletManager.instance.isActivate)
                  {
                     _alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.horseAmulet.replaceTips"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true);
                     _alertFrame.addEventListener("response",__onClickFrame);
                  }
                  else
                  {
                     SocketManager.Instance.out.sendAmuletMove(_oldPlace,_newPlace);
                  }
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.activateFail"));
                  DragManager.acceptDrag(null,"none");
                  return;
               }
            }
            DragManager.acceptDrag(this,"move");
            return;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.notMove"));
         DragManager.acceptDrag(this,"none");
      }
      
      private function __updateGoods(evt:BagEvent) : void
      {
         var changes:Dictionary = evt.changedSlots;
         var _loc5_:int = 0;
         var _loc4_:* = changes;
         for each(var i in changes)
         {
            if(i.Place == 19)
            {
               this.info = _bag.getItemAt(i.Place);
            }
         }
      }
      
      protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if(_info)
         {
            SoundManager.instance.playButtonSound();
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _oldPlace = 19;
            _newPlace = getBagCellIndex();
            if(HorseAmuletManager.instance.isActivate)
            {
               _alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.horseAmulet.replaceTips"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true);
               _alertFrame.addEventListener("response",__onClickFrame);
            }
            else
            {
               SocketManager.Instance.out.sendAmuletMove(_oldPlace,_newPlace);
            }
         }
      }
      
      private function __onClickFrame(e:FrameEvent) : void
      {
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            if(_newPlace > 0)
            {
               SocketManager.Instance.out.sendAmuletMove(_oldPlace,_newPlace);
            }
         }
         disposeAlertFrame();
      }
      
      private function disposeAlertFrame() : void
      {
         if(_alertFrame)
         {
            _alertFrame.removeEventListener("response",__onClickFrame);
            ObjectUtils.disposeObject(_alertFrame);
            _alertFrame = null;
         }
      }
      
      private function getBagCellIndex() : int
      {
         var i:int = 0;
         var info:* = null;
         for(i = 20; i < 167; )
         {
            info = PlayerManager.Instance.Self.horseAmuletBag.getItemAt(i);
            if(info == null)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function createBg() : Shape
      {
         var shape:Shape = new Shape();
         shape.graphics.beginFill(0,0);
         shape.graphics.drawRect(0,0,75,75);
         shape.graphics.endFill();
         return shape;
      }
      
      override public function dispose() : void
      {
         if(this.info)
         {
            SocketManager.Instance.out.sendAmuletMove(19,getBagCellIndex());
         }
         disposeAlertFrame();
         this.removeEventListener("interactive_double_click",__doubleClickHandler);
         _bag.removeEventListener("update",__updateGoods);
         _bag = null;
         DoubleClickManager.Instance.disableDoubleClick(this);
         super.dispose();
      }
   }
}
