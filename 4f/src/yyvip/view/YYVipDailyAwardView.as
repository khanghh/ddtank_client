package yyvip.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.RequestLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import yyvip.YYVipControl;
   
   public class YYVipDailyAwardView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _yearGetBtn:SimpleBitmapButton;
      
      private var _levelAwardList:Vector.<YYVipLevelAwardCell>;
      
      private var _yearAwardList:Vector.<YYVipAwardCell>;
      
      public function YYVipDailyAwardView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function refreshBtnStatus(param1:int, param2:int) : void{}
      
      private function getClickHandler(param1:MouseEvent) : void{}
      
      private function __onRequestError(param1:LoaderEvent) : void{}
      
      private function __onRequestComplete(param1:LoaderEvent) : void{}
      
      private function guideToOpen(param1:String) : void{}
      
      private function confirmHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
