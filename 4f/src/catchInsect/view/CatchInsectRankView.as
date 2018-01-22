package catchInsect.view
{
   import catchInsect.CatchInsectManager;
   import catchInsect.componets.CatchInsectRankCell;
   import catchInsect.data.CatchInsectRankInfo;
   import catchInsect.event.CatchInsectEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import road7th.comm.PackageIn;
   
   public class CatchInsectRankView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _listItem:Vector.<CatchInsectRankCell>;
      
      private var _myRankImg:Bitmap;
      
      private var _txtBg:Scale9CornerImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nextDescTxt:FilterFrameText;
      
      private var _needTxt:FilterFrameText;
      
      private var _type:int;
      
      public function CatchInsectRankView(param1:int){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      protected function __updateSelfInfo(param1:CatchInsectEvent) : void{}
      
      protected function __updateRankInfo(param1:CatchInsectEvent) : void{}
      
      private function clearItems() : void{}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
   }
}
