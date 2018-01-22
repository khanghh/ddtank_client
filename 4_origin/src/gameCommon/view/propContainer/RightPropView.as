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
       
      
      public function RightPropView(param1:LocalPlayer)
      {
         super(param1,8,1,false,false,false,"rightPropView");
         initView();
         setItem();
      }
      
      private function initView() : void
      {
         _itemContainer.vSpace = 4;
      }
      
      private function __keyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:* = param1.keyCode;
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
            addr134:
            return;
         }
         _itemContainer.mouseClickAt(0);
         §§goto(addr134);
      }
      
      public function setItem() : void
      {
         var _loc7_:* = null;
         var _loc2_:* = null;
         _itemContainer.clear();
         var _loc1_:Boolean = false;
         var _loc5_:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.findFistItemByTemplateId(10200,true,true);
         var _loc3_:Object = SharedManager.Instance.GameKeySets;
         var _loc11_:int = 0;
         var _loc10_:* = _loc3_;
         for(var _loc4_ in _loc3_)
         {
            if(int(_loc4_) != 9)
            {
               _loc7_ = new PropInfo(ItemManager.Instance.getTemplateById(_loc3_[_loc4_]));
               if(_loc5_ || PlayerManager.Instance.Self.hasBuff(15))
               {
                  if(_loc5_)
                  {
                     _loc7_.Place = _loc5_.Place;
                  }
                  else
                  {
                     _loc7_.Place = -1;
                  }
                  _loc7_.Count = -1;
                  _itemContainer.appendItemAt(new PropItemView(_loc7_,true,false,-1),int(_loc4_) - 1);
                  _loc1_ = true;
               }
               else
               {
                  _loc2_ = PlayerManager.Instance.Self.PropBag.findItemsByTempleteID(_loc3_[_loc4_]);
                  if(_loc2_.length > 0)
                  {
                     _loc7_.Place = _loc2_[0].Place;
                     var _loc9_:int = 0;
                     var _loc8_:* = _loc2_;
                     for each(var _loc6_ in _loc2_)
                     {
                        _loc7_.Count = _loc7_.Count + _loc6_.Count;
                     }
                     _itemContainer.appendItemAt(new PropItemView(_loc7_,true,false),int(_loc4_) - 1);
                     _loc1_ = true;
                  }
                  else
                  {
                     _itemContainer.appendItemAt(new PropItemView(_loc7_,false,false),int(_loc4_) - 1);
                  }
               }
               continue;
            }
            break;
         }
         if(_loc1_)
         {
            _itemContainer.setClickByEnergy(self.energy);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
      }
      
      override protected function __click(param1:ItemEvent) : void
      {
         var _loc2_:PropItemView = param1.item as PropItemView;
         var _loc3_:PropInfo = _loc2_.info;
         if(_loc2_.isExist)
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
            if(self.energy < _loc3_.needEnergy)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.actions.SelfPlayerWalkAction"));
               return;
            }
            self.useItem(_loc3_.Template);
            GameInSocketOut.sendUseProp(1,_loc3_.Place,_loc3_.Template.TemplateID);
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
