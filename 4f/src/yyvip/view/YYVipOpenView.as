package yyvip.view
{
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.RequestLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import yyvip.YYVipControl;
   
   public class YYVipOpenView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _openBtn:SimpleBitmapButton;
      
      private var _tipTxt:FilterFrameText;
      
      private var _awardList:Vector.<YYVipAwardCell>;
      
      public function YYVipOpenView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function openClickHandler(param1:MouseEvent) : void{}
      
      private function getClickHandler(param1:MouseEvent) : void{}
      
      private function __onRequestError(param1:LoaderEvent) : void{}
      
      private function __onRequestComplete(param1:LoaderEvent) : void{}
      
      public function refreshOpenOrCostBtn(param1:int, param2:int) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
