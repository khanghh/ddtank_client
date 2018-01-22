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
      
      public function SelfPropContainBar(param1:LocalPlayer)
      {
         super(param1,3,3,false,false,false,"propShortCutView");
         _back = ComponentFactory.Instance.creatBitmap("asset.game.propBackAsset");
         addChild(_back);
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("asset.game.itemContainerPos");
         _itemContainer.x = _loc2_.x;
         _itemContainer.y = _loc2_.y;
         addChild(_itemContainer);
         _shortCut = new PropShortCutView();
         _shortCut.setPropCloseEnabled(0,false);
         _shortCut.setPropCloseEnabled(1,false);
         _shortCut.setPropCloseEnabled(2,false);
         addChild(_shortCut);
         setLocalPlayer(param1.playerInfo as SelfInfo);
         initData();
      }
      
      private function initData() : void
      {
         var _loc2_:* = null;
         var _loc1_:BagInfo = _info.FightBag;
         var _loc5_:int = 0;
         var _loc4_:* = _loc1_.items;
         for each(var _loc3_ in _loc1_.items)
         {
            _loc2_ = new PropInfo(_loc3_);
            _loc2_.Place = _loc3_.Place;
            addProp(_loc2_);
         }
      }
      
      private function __keyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:* = param1.keyCode;
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
      
      public function setLocalPlayer(param1:SelfInfo) : void
      {
         if(_info != param1)
         {
            if(_info)
            {
               _info.FightBag.removeEventListener("update",__updateProp);
               _itemContainer.clear();
            }
            _info = param1;
            if(_info)
            {
               _info.FightBag.addEventListener("update",__updateProp);
            }
         }
      }
      
      private function __removeProp(param1:BagEvent) : void
      {
         var _loc2_:PropInfo = new PropInfo(param1.changedSlots as InventoryItemInfo);
         _loc2_.Place = param1.changedSlots.Place;
         removeProp(_loc2_ as PropInfo);
      }
      
      private function __updateProp(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc6_:Dictionary = param1.changedSlots;
         var _loc8_:int = 0;
         var _loc7_:* = _loc6_;
         for each(var _loc5_ in _loc6_)
         {
            _loc2_ = _info.FightBag.getItemAt(_loc5_.Place);
            if(_loc2_)
            {
               _loc3_ = new PropInfo(_loc2_);
               _loc3_.Place = _loc2_.Place;
               addProp(_loc3_);
            }
            else
            {
               _loc4_ = new PropInfo(_loc5_);
               _loc4_.Place = _loc5_.Place;
               removeProp(_loc4_);
            }
         }
      }
      
      override public function setClickEnabled(param1:Boolean, param2:Boolean) : void
      {
         super.setClickEnabled(param1,param2);
      }
      
      override protected function __click(param1:ItemEvent) : void
      {
         var _loc2_:* = null;
         if(param1.item == null)
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
            if(self.energy >= Number(PropItemView(param1.item).info.Template.Property4))
            {
               _loc2_ = PropItemView(param1.item).info;
               self.useItem(_loc2_.Template);
               GameInSocketOut.sendUseProp(2,_loc2_.Place,_loc2_.Template.TemplateID);
               if(_loc2_.Template.TemplateID == 10003)
               {
                  dispatchEvent(new Event(USE_THREE_SKILL));
               }
               if(_loc2_.Template.TemplateID == 10016)
               {
                  dispatchEvent(new Event(USE_PLANE));
               }
               _itemContainer.setItemClickAt(_loc2_.Place,false,true);
               _shortCut.setPropCloseVisible(_loc2_.Place,false);
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.actions.SelfPlayerWalkAction"));
            }
         }
      }
      
      override protected function __over(param1:ItemEvent) : void
      {
         super.__over(param1);
         _shortCut.setPropCloseVisible(param1.index,true);
      }
      
      override protected function __out(param1:ItemEvent) : void
      {
         super.__out(param1);
         _shortCut.setPropCloseVisible(param1.index,false);
      }
      
      public function addProp(param1:PropInfo) : void
      {
         _shortCut.setPropCloseEnabled(param1.Place,true);
         _itemContainer.appendItemAt(new PropItemView(param1,true,false),param1.Place);
      }
      
      public function removeProp(param1:PropInfo) : void
      {
         _shortCut.setPropCloseEnabled(param1.Place,false);
         _shortCut.setPropCloseVisible(param1.Place,false);
         _itemContainer.removeItemAt(param1.Place);
      }
   }
}
