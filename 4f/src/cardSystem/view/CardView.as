package cardSystem.view
{
   import cardSystem.data.CardInfo;
   import cardSystem.view.cardBag.CardBagView;
   import cardSystem.view.cardEquip.CardEquipView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CardView extends Sprite implements Disposeable
   {
       
      
      private var _cardEquip:CardEquipView;
      
      private var _cardBag:CardBagView;
      
      private var _playerInfo:PlayerInfo;
      
      private var _helpBtn:BaseButton;
      
      private var _helpFrame:Frame;
      
      private var _okBtn:TextButton;
      
      private var _content:Bitmap;
      
      public function CardView(){super();}
      
      private function initView() : void{}
      
      public function set playerInfo(param1:PlayerInfo) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __dragStartHandler(param1:CellEvent) : void{}
      
      private function __dragStopHandler(param1:CellEvent) : void{}
      
      public function dispose() : void{}
      
      private function __helpHandler(param1:MouseEvent) : void{}
      
      protected function __helpFrameRespose(param1:FrameEvent) : void{}
      
      private function disposeHelpFrame() : void{}
      
      protected function __closeHelpFrame(param1:MouseEvent) : void{}
   }
}
