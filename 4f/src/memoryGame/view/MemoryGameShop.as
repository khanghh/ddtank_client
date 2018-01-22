package memoryGame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import memoryGame.MemoryGameManager;
   import memoryGame.data.MemoryGameGoodsInfo;
   
   public class MemoryGameShop extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _timeText:FilterFrameText;
      
      private var _contentText:FilterFrameText;
      
      private var _scoreText:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function MemoryGameShop(){super();}
      
      private function init() : void{}
      
      public function update() : void{}
      
      public function dispose() : void{}
   }
}
