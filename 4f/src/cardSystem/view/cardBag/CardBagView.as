package cardSystem.view.cardBag
{
   import cardSystem.CardControl;
   import cardSystem.CardManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.SetsInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.OutMainListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class CardBagView extends Sprite implements Disposeable
   {
       
      
      private var _sortBtn:BaseButton;
      
      private var _collectBtn:BaseButton;
      
      private var _BG:Bitmap;
      
      private var _title:Bitmap;
      
      private var _bagList:OutMainListPanel;
      
      public function CardBagView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __collectHandler(param1:MouseEvent) : void{}
      
      private function __upData(param1:DictionaryEvent) : void{}
      
      private function __remove(param1:DictionaryEvent) : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
