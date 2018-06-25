package gameCommon.view.propContainer
{
   import bombKing.BombKingManager;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.ItemEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.PropItemView;
   import flash.events.KeyboardEvent;
   import gameCommon.model.LocalPlayer;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   
   public class RightPropView extends BaseGamePropBarView
   {
      
      private static const PROP_ID:int = 10;
       
      
      public function RightPropView(self:LocalPlayer)
      {
         super(self,8,1,false,false,false,"rightPropView");
         initView();
         setItem();
      }
      
      private function initView() : void
      {
         _itemContainer.vSpace = 4;
      }
      
      private function __keyDown(event:KeyboardEvent) : void
      {
         var _loc2_:* = event.keyCode;
         if(KeyStroke.VK_1.getCode() !== _loc2_)
         {
            if(KeyStroke.VK_NUMPAD_1.getCode() !== _loc2_)
            {
               if(KeyStroke.VK_2.getCode() !== _loc2_)
               {
                  if(KeyStroke.VK_NUMPAD_2.getCode() !== _loc2_)
                  {
                     if(KeyStroke.VK_3.getCode() !== _loc2_)
                     {
                        if(KeyStroke.VK_NUMPAD_3.getCode() !== _loc2_)
                        {
                           if(KeyStroke.VK_4.getCode() !== _loc2_)
                           {
                              if(KeyStroke.VK_NUMPAD_4.getCode() !== _loc2_)
                              {
                                 if(KeyStroke.VK_5.getCode() !== _loc2_)
                                 {
                                    if(KeyStroke.VK_NUMPAD_5.getCode() !== _loc2_)
                                    {
                                       if(KeyStroke.VK_6.getCode() !== _loc2_)
                                       {
                                          if(KeyStroke.VK_NUMPAD_6.getCode() !== _loc2_)
                                          {
                                             if(KeyStroke.VK_7.getCode() !== _loc2_)
                                             {
                                                if(KeyStroke.VK_NUMPAD_7.getCode() !== _loc2_)
                                                {
                                                   if(KeyStroke.VK_8.getCode() !== _loc2_)
                                                   {
                                                      if(KeyStroke.VK_NUMPAD_8.getCode() !== _loc2_)
                                                      {
                                                      }
                                                   }
                                                   _itemContainer.mouseClickAt(7);
                                                }
                                             }
                                             _itemContainer.mouseClickAt(6);
                                          }
                                       }
                                       _itemContainer.mouseClickAt(5);
                                    }
                                 }
                                 _itemContainer.mouseClickAt(4);
                              }
                           }
                           _itemContainer.mouseClickAt(3);
                        }
                     }
                     _itemContainer.mouseClickAt(2);
                  }
               }
               _itemContainer.mouseClickAt(1);
            }
            addr162:
            return;
         }
         _itemContainer.mouseClickAt(0);
         §§goto(addr162);
      }
      
      public function setItem() : void
      {
         var info:* = null;
         var items:* = null;
         _itemContainer.clear();
         var hasItem:Boolean = false;
         var propAllProp:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.findFistItemByTemplateId(10200,true,true);
         var _sets:Object = SharedManager.Instance.GameKeySets;
         var _loc11_:int = 0;
         var _loc10_:* = _sets;
         for(var propId in _sets)
         {
            if(int(propId) != 9)
            {
               info = new PropInfo(ItemManager.Instance.getTemplateById(_sets[propId]));
               if(propAllProp || PlayerManager.Instance.Self.hasBuff(15))
               {
                  if(propAllProp)
                  {
                     info.Place = propAllProp.Place;
                  }
                  else
                  {
                     info.Place = -1;
                  }
                  info.Count = -1;
                  _itemContainer.appendItemAt(new PropItemView(info,true,false,-1),int(propId) - 1);
                  hasItem = true;
               }
               else
               {
                  items = PlayerManager.Instance.Self.PropBag.findItemsByTempleteID(_sets[propId]);
                  if(items.length > 0)
                  {
                     info.Place = items[0].Place;
                     var _loc9_:int = 0;
                     var _loc8_:* = items;
                     for each(var i in items)
                     {
                        info.Count = info.Count + i.Count;
                     }
                     _itemContainer.appendItemAt(new PropItemView(info,true,false),int(propId) - 1);
                     hasItem = true;
                  }
                  else
                  {
                     _itemContainer.appendItemAt(new PropItemView(info,false,false),int(propId) - 1);
                  }
               }
               continue;
            }
            break;
         }
         if(hasItem)
         {
            _itemContainer.setClickByEnergy(self.energy);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
      }
      
      override protected function __click(event:ItemEvent) : void
      {
         var itemView:PropItemView = event.item as PropItemView;
         var item:PropInfo = itemView.info;
         if(itemView.isExist)
         {
            if(self.isLiving == false)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.RightPropView.prop"));
               return;
            }
            if(!self.isAttacking || BombKingManager.instance.Recording)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.ArrowViewIII.fall"));
               return;
            }
            if(self.LockState)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.cantUseItem"));
               return;
            }
            if(self.energy < item.needEnergy)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.actions.SelfPlayerWalkAction"));
               return;
            }
            self.useItem(item.Template);
            GameInSocketOut.sendUseProp(1,item.Place,item.Template.TemplateID);
         }
         else
         {
            SoundManager.instance.play("008");
         }
      }
      
      private function confirm() : void
      {
         if(PlayerManager.Instance.Self.Money >= ShopManager.Instance.getMoneyShopItemByTemplateID(11995).getItemPrice(1).bothMoneyValue)
         {
            SocketManager.Instance.out.sendUseCard(-1,-1,[11995],1,true);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIBtnPanel.stipple"));
         }
      }
   }
}
