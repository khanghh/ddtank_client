package gameCommon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.BagInfo;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.events.ItemEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.view.PropItemView;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import gameCommon.model.LocalPlayer;
   import gameCommon.view.propContainer.BaseGamePropBarView;
   import gameCommon.view.propContainer.PropShortCutView;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   
   public class SelfPropContainBar extends BaseGamePropBarView
   {
      
      public static var USE_THREE_SKILL:String = "useThreeSkill";
      
      public static var USE_PLANE:String = "usePlane";
       
      
      private var _back:Bitmap;
      
      private var _info:SelfInfo;
      
      private var _shortCut:PropShortCutView;
      
      private var _myitems:Array;
      
      public function SelfPropContainBar(self:LocalPlayer)
      {
         super(self,3,3,false,false,false,"propShortCutView");
         _back = ComponentFactory.Instance.creatBitmap("asset.game.propBackAsset");
         addChild(_back);
         var itemPos:Point = ComponentFactory.Instance.creatCustomObject("asset.game.itemContainerPos");
         _itemContainer.x = itemPos.x;
         _itemContainer.y = itemPos.y;
         addChild(_itemContainer);
         _shortCut = new PropShortCutView();
         _shortCut.setPropCloseEnabled(0,false);
         _shortCut.setPropCloseEnabled(1,false);
         _shortCut.setPropCloseEnabled(2,false);
         addChild(_shortCut);
         setLocalPlayer(self.playerInfo as SelfInfo);
         initData();
      }
      
      private function initData() : void
      {
         var propInfo:* = null;
         var bag:BagInfo = _info.FightBag;
         var _loc5_:int = 0;
         var _loc4_:* = bag.items;
         for each(var info in bag.items)
         {
            propInfo = new PropInfo(info);
            propInfo.Place = info.Place;
            addProp(propInfo);
         }
      }
      
      private function __keyDown(event:KeyboardEvent) : void
      {
         var _loc2_:* = event.keyCode;
         if(KeyStroke.VK_Z.getCode() !== _loc2_)
         {
            if(KeyStroke.VK_X.getCode() !== _loc2_)
            {
               if(KeyStroke.VK_C.getCode() === _loc2_)
               {
                  _itemContainer.mouseClickAt(2);
               }
            }
            else
            {
               _itemContainer.mouseClickAt(1);
            }
         }
         else
         {
            _itemContainer.mouseClickAt(0);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_shortCut)
         {
            _shortCut.dispose();
         }
         _shortCut = null;
         removeChild(_back);
         _info = null;
         KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
      }
      
      public function setLocalPlayer(value:SelfInfo) : void
      {
         if(_info != value)
         {
            if(_info)
            {
               _info.FightBag.removeEventListener("update",__updateProp);
               _itemContainer.clear();
            }
            _info = value;
            if(_info)
            {
               _info.FightBag.addEventListener("update",__updateProp);
            }
         }
      }
      
      private function __removeProp(event:BagEvent) : void
      {
         var propInfo:PropInfo = new PropInfo(event.changedSlots as InventoryItemInfo);
         propInfo.Place = event.changedSlots.Place;
         removeProp(propInfo as PropInfo);
      }
      
      private function __updateProp(event:BagEvent) : void
      {
         var c:* = null;
         var propInfo:* = null;
         var propInfo1:* = null;
         var changes:Dictionary = event.changedSlots;
         var _loc8_:int = 0;
         var _loc7_:* = changes;
         for each(var i in changes)
         {
            c = _info.FightBag.getItemAt(i.Place);
            if(c)
            {
               propInfo = new PropInfo(c);
               propInfo.Place = c.Place;
               addProp(propInfo);
            }
            else
            {
               propInfo1 = new PropInfo(i);
               propInfo1.Place = i.Place;
               removeProp(propInfo1);
            }
         }
      }
      
      override public function setClickEnabled(clickAble:Boolean, isGray:Boolean) : void
      {
         super.setClickEnabled(clickAble,isGray);
      }
      
      override protected function __click(event:ItemEvent) : void
      {
         var info:* = null;
         if(event.item == null)
         {
            return;
         }
         if(self.LockState)
         {
            if(self.LockType == 0)
            {
               return;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop.effect.seal"));
         }
         else
         {
            if(self.isLiving && !self.isAttacking)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.ArrowViewIII.fall"));
               return;
            }
            if(self.energy >= Number(PropItemView(event.item).info.Template.Property4))
            {
               info = PropItemView(event.item).info;
               self.useItem(info.Template);
               GameInSocketOut.sendUseProp(2,info.Place,info.Template.TemplateID);
               if(info.Template.TemplateID == 10003)
               {
                  dispatchEvent(new Event(USE_THREE_SKILL));
               }
               if(info.Template.TemplateID == 10016)
               {
                  dispatchEvent(new Event(USE_PLANE));
               }
               _itemContainer.setItemClickAt(info.Place,false,true);
               _shortCut.setPropCloseVisible(info.Place,false);
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.actions.SelfPlayerWalkAction"));
            }
         }
      }
      
      override protected function __over(event:ItemEvent) : void
      {
         super.__over(event);
         _shortCut.setPropCloseVisible(event.index,true);
      }
      
      override protected function __out(event:ItemEvent) : void
      {
         super.__out(event);
         _shortCut.setPropCloseVisible(event.index,false);
      }
      
      public function addProp(info:PropInfo) : void
      {
         _shortCut.setPropCloseEnabled(info.Place,true);
         _itemContainer.appendItemAt(new PropItemView(info,true,false),info.Place);
      }
      
      public function removeProp(info:PropInfo) : void
      {
         _shortCut.setPropCloseEnabled(info.Place,false);
         _shortCut.setPropCloseVisible(info.Place,false);
         _itemContainer.removeItemAt(info.Place);
      }
   }
}
