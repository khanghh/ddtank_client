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
       
      
      public function RightPropView(param1:LocalPlayer){super(null,null,null,null,null,null,null);}
      
      private function initView() : void{}
      
      private function __keyDown(param1:KeyboardEvent) : void{}
      
      public function setItem() : void{}
      
      override public function dispose() : void{}
      
      override protected function __click(param1:ItemEvent) : void{}
      
      private function confirm() : void{}
   }
}
