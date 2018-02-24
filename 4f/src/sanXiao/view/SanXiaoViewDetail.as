package sanXiao.view
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
   import road7th.utils.DateUtils;
   import sanXiao.SanXiaoManager;
   
   public class SanXiaoViewDetail extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _timeRemainText:FilterFrameText;
      
      private var _detailText:FilterFrameText;
      
      private var _priseText:FilterFrameText;
      
      private var _itemList:Vector.<SXRewardItem>;
      
      private var _itemContainer:VBox;
      
      private var _scroll:ScrollPanel;
      
      public function SanXiaoViewDetail(){super();}
      
      private function init() : void{}
      
      private function addEvents() : void{}
      
      private function removeEvents() : void{}
      
      public function update() : void{}
      
      public function dispose() : void{}
   }
}
