package totem.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.view.DoubleSelectedItem;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import totem.HonorUpManager;
   import totem.data.HonorUpDataVo;
   
   public class HonorUpFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _btnBg:Bitmap;
      
      private var _tip1:FilterFrameText;
      
      private var _upBtn:SimpleBitmapButton;
      
      private var _selecteItem:DoubleSelectedItem;
      
      public function HonorUpFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function refreshShow(param1:Event) : void{}
      
      private function doUpHonor(param1:MouseEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
