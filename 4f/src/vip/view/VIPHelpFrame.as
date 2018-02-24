package vip.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import game.GameManager;
   import vip.VipController;
   
   public class VIPHelpFrame extends Frame
   {
       
      
      private var content:MovieClip;
      
      private var openVip:BaseButton;
      
      private var _openFun:Function;
      
      private var _contentScroll:ScrollPanel;
      
      private var _buttomBit:ScaleBitmapImage;
      
      public function VIPHelpFrame(){super();}
      
      private function initFrame() : void{}
      
      public function set openFun(param1:Function) : void{}
      
      public function show() : void{}
      
      private function __open(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
