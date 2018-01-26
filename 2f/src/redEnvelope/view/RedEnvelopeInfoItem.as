package redEnvelope.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import redEnvelope.RedEnvelopeManager;
   import redEnvelope.event.RedEnvelopeEvent;
   
   public class RedEnvelopeInfoItem extends Sprite
   {
       
      
      private var _redInfoTxt:FilterFrameText;
      
      public var getBtn:BaseButton;
      
      private var redCell:BagCell;
      
      private var _itemSelected:Bitmap;
      
      private var _bg:Bitmap;
      
      public var _id:int;
      
      private var _clickTime:Number = 0;
      
      public function RedEnvelopeInfoItem(param1:int, param2:int, param3:String, param4:int, param5:Boolean = true){super();}
      
      private function thisClickHandler(param1:MouseEvent) : void{}
      
      public function btnDarkSet() : void{}
      
      public function unSelectSet() : void{}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
