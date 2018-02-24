package happyLittleGame.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import funnyGames.FunnyGamesManager;
   import funnyGames.event.FunnyGamesEvent;
   import happyLittleGame.rank.items.SimpleGameRankItem;
   import uiModeManager.bombUI.HappyLittleGameManager;
   import uiModeManager.bombUI.model.rank.HappyMiniGameRankData;
   import uiUtils.SelectPageUI;
   
   public class SimpleGameRankFrame extends Frame
   {
      
      private static const COLUMN_CNT:uint = 10;
       
      
      private var _bg:Bitmap;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _selectPageUI:SelectPageUI;
      
      private var _list:VBox;
      
      private var _noRankTxt:FilterFrameText;
      
      private var _pageIdx:uint = 1;
      
      private var _itemList:Vector.<SimpleGameRankItem>;
      
      public function SimpleGameRankFrame(){super();}
      
      private function initView() : void{}
      
      private function initListener() : void{}
      
      private function removeListener() : void{}
      
      private function onHelpClick(param1:MouseEvent) : void{}
      
      private function onPageChange(param1:Event) : void{}
      
      private function __updateView(param1:FunnyGamesEvent) : void{}
      
      private function updateView() : void{}
      
      private function clearItemList() : void{}
      
      public function show() : void{}
      
      override public function dispose() : void{}
      
      override protected function onResponse(param1:int) : void{}
   }
}
