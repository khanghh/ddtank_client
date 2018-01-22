package treasureHunting.views
{
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.InventoryItemAnalyzer;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.RouletteManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import treasureHunting.TreasureControl;
   import treasureHunting.TreasureManager;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.views.IRightView;
   
   public class TreasureEnterView extends Sprite implements IRightView
   {
       
      
      private var _content:Sprite;
      
      private var _enterBG:Bitmap;
      
      private var _enterBtn:SimpleBitmapButton;
      
      private var _remain:FilterFrameText;
      
      private var _treasureFrame:TreasureHuntingFrame;
      
      public function TreasureEnterView(){super();}
      
      public function init() : void{}
      
      private function init2() : void{}
      
      private function initView() : void{}
      
      private function initTimer() : void{}
      
      private function treasureTimerHandler() : void{}
      
      private function initEvent() : void{}
      
      protected function onEnterBtnClick(param1:MouseEvent) : void{}
      
      private function loadComplete(param1:InventoryItemAnalyzer) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
      
      public function content() : Sprite{return null;}
      
      public function setState(param1:int, param2:int) : void{}
   }
}
