package ddt.view.caddyII.badLuck
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.RouletteManager;
   import ddt.manager.SoundManager;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.reader.CaddyReadAwardsView;
   import ddt.view.caddyII.reader.CaddyUpdate;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BadLuckView extends Sprite implements Disposeable, CaddyUpdate
   {
       
      
      private var _bg1:ScaleBitmapImage;
      
      private var _bg2:MutipleImage;
      
      private var _awardBtn:SelectedTextButton;
      
      private var _badLuckBtn:SelectedTextButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _lastTimeTxt:FilterFrameText;
      
      private var _myNumberTxt:FilterFrameText;
      
      private var _caddyBadLuckView:CaddyBadLuckView;
      
      private var _readView:CaddyReadAwardsView;
      
      private var _bottomBG:MutipleImage;
      
      public function BadLuckView(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __awardBtnClick(param1:MouseEvent) : void{}
      
      private function __badLuckBtnClick(param1:MouseEvent) : void{}
      
      private function __updateLastTime(param1:CaddyEvent) : void{}
      
      private function __changeBadLuckNumber(param1:PlayerPropertyEvent) : void{}
      
      public function update() : void{}
      
      public function dispose() : void{}
   }
}
