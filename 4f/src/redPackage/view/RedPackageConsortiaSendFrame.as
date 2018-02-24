package redPackage.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.NumberSelecter;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import redPackage.RedPackageManager;
   
   public class RedPackageConsortiaSendFrame extends Frame
   {
       
      
      private var _bg:MutipleImage;
      
      private var _titleBmp:Bitmap;
      
      private var _moneyLabel:FilterFrameText;
      
      private var _moneyBG:Scale9CornerImage;
      
      private var _moneyTextField:FilterFrameText;
      
      private var _pkgNumberLabel:FilterFrameText;
      
      private var _pkgNumberSelecter:NumberSelecter;
      
      private var _wishWordsTextField:FilterFrameText;
      
      private var _wishWordsBG:Bitmap;
      
      private var _sendBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _isAverage:SelectedCheckButton;
      
      private var img:ScaleBitmapImage;
      
      private var _scrollPanel:ListPanel;
      
      private var content:Sprite;
      
      public function RedPackageConsortiaSendFrame(){super();}
      
      override public function set backgound(param1:DisplayObject) : void{}
      
      override protected function init() : void{}
      
      private function addEvents() : void{}
      
      protected function onATS(param1:Event) : void{}
      
      protected function onSendBtnClick(param1:MouseEvent) : void{}
      
      private function removeEvents() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function close() : void{}
      
      override public function dispose() : void{}
   }
}
