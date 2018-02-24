package drgnBoat.views
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import drgnBoat.DrgnBoatManager;
   import drgnBoat.event.DrgnBoatEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class DrgnBoatRankView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _moveInBtn:SimpleBitmapButton;
      
      private var _moveOutBtn:SimpleBitmapButton;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _rateTxt:FilterFrameText;
      
      private var _rankCellList:Vector.<DrgnBoatRankCell>;
      
      public function DrgnBoatRankView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function outHandler(param1:MouseEvent) : void{}
      
      private function setInOutVisible(param1:Boolean) : void{}
      
      private function inHandler(param1:MouseEvent) : void{}
      
      private function refreshRankList(param1:DrgnBoatEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
