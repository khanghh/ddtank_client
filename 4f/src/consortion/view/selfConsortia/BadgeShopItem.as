package consortion.view.selfConsortia
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.BadgeInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BadgeShopItem extends Sprite implements Disposeable
   {
       
      
      private var _badge:Badge;
      
      private var _btn:SimpleBitmapButton;
      
      private var _nametxt:FilterFrameText;
      
      private var _day:FilterFrameText;
      
      private var _pay:FilterFrameText;
      
      private var _info:BadgeInfo;
      
      private var _bg:ScaleBitmapImage;
      
      private var _cellBG:DisplayObject;
      
      private var _line:MutipleImage;
      
      private var _alert:BaseAlerFrame;
      
      public function BadgeShopItem(param1:BadgeInfo){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onClick(param1:MouseEvent) : void{}
      
      private function onResponse(param1:FrameEvent) : void{}
      
      public function dispose() : void{}
   }
}
