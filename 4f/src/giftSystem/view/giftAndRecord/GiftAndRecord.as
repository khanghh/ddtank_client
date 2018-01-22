package giftSystem.view.giftAndRecord
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import giftSystem.GiftManager;
   import giftSystem.MyGiftCellInfo;
   import road7th.data.DictionaryEvent;
   
   public class GiftAndRecord extends Sprite implements Disposeable
   {
      
      public static const MYGIFT:int = 0;
      
      public static const GIFTRECORD:int = 1;
       
      
      private var _BG:ScaleBitmapImage;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _myGiftBtn:SelectedTextButton;
      
      private var _giftRecordBtn:SelectedTextButton;
      
      private var _myGiftView:MyGiftView;
      
      private var _giftRecord:GiftRecord;
      
      private var _info:PlayerInfo;
      
      public function GiftAndRecord(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __upMyGiftView(param1:Event) : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      private function showMyGiftView() : void{}
      
      private function showGiftRecord() : void{}
      
      public function set info(param1:PlayerInfo) : void{}
      
      private function __upItem(param1:DictionaryEvent) : void{}
      
      private function __addItem(param1:DictionaryEvent) : void{}
      
      private function __upData(param1:PlayerPropertyEvent) : void{}
      
      private function __soundPlay(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
