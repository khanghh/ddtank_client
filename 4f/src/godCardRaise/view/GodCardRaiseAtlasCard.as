package godCardRaise.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.info.GodCardListInfo;
   
   public class GodCardRaiseAtlasCard extends Sprite implements Disposeable
   {
       
      
      private var _info:GodCardListInfo;
      
      private var _countTxt:FilterFrameText;
      
      private var _picSp:Sprite;
      
      private var _loaderPic:DisplayLoader;
      
      private var _picBmp:Bitmap;
      
      private var _compositeBtn:BaseButton;
      
      private var _smashBtn:BaseButton;
      
      private var _btnBg:Shape;
      
      private var _cardCount:int;
      
      private var _clickNum:Number = 0;
      
      private var _btnType:int;
      
      private var _alert:GodCardRaiseAtlasCardAlert;
      
      public function GodCardRaiseAtlasCard(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function onMouseOver(param1:MouseEvent) : void{}
      
      private function onMouseOut(param1:MouseEvent) : void{}
      
      public function updateView() : void{}
      
      public function set info(param1:GodCardListInfo) : void{}
      
      private function __picComplete(param1:LoaderEvent) : void{}
      
      private function __compositeBtnHandler(param1:MouseEvent) : void{}
      
      private function showAlert(param1:int) : void{}
      
      private function __alertResponse(param1:FrameEvent) : void{}
      
      private function __smashBtnHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
