package email.view
{
   import baglocked.BaglockedManager;
   import baglocked.SetPassEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.email.EmailInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import email.MailManager;
   import email.manager.MailControl;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.media.SoundTransform;
   import flash.text.TextFormat;
   import giftSystem.GiftManager;
   
   public class EmailStrip extends Sprite implements Disposeable
   {
      
      public static const SELECT:String = "select";
       
      
      protected var _info:EmailInfo;
      
      protected var _isReading:Boolean;
      
      protected var _checkBox:SelectedCheckButton;
      
      protected var _cell:DiamondOfStrip;
      
      protected var _emailStripBg:MovieClip;
      
      protected var _deleteBtn:BaseButton;
      
      protected var _GMImg:Bitmap;
      
      protected var _emailType:ScaleFrameImage;
      
      protected var _EggKingImg:Bitmap;
      
      protected var _topicTxt:FilterFrameText;
      
      protected var _senderTxt:FilterFrameText;
      
      protected var _validityTxt:FilterFrameText;
      
      protected var _payImg:Bitmap;
      
      protected var _unReadImg:Bitmap;
      
      private var _deleteAlert:BaseAlerFrame;
      
      protected var _unXinImg:Bitmap;
      
      protected var _payIMGII:Bitmap;
      
      private var _emptyItem:Boolean = false;
      
      private var _movie:MovieClip;
      
      private var _soundControl:SoundTransform;
      
      public function EmailStrip(){super();}
      
      protected function initView() : void{}
      
      private function creatMaskSprit() : Sprite{return null;}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function set info(param1:EmailInfo) : void{}
      
      public function get info() : EmailInfo{return null;}
      
      public function set isReading(param1:Boolean) : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function update() : void{}
      
      private function __delete(param1:MouseEvent) : void{}
      
      private function disposeAlert() : void{}
      
      private function __cancelBtn(param1:SetPassEvent) : void{}
      
      private function __deleteAlertResponse(param1:FrameEvent) : void{}
      
      private function cancel() : void{}
      
      private function ok() : void{}
      
      public function get emptyItem() : Boolean{return false;}
      
      private function clearItem() : void{}
      
      private function __over(param1:MouseEvent) : void{}
      
      private function __out(param1:MouseEvent) : void{}
      
      private function __click(param1:MouseEvent) : void{}
      
      protected function __removeMovie(param1:Event) : void{}
      
      protected function __addClickEvent(param1:Event) : void{}
      
      protected function __movieClickHandler(param1:Event) : void{}
      
      override public function get height() : Number{return 0;}
      
      public function dispose() : void{}
   }
}
