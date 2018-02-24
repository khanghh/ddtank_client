package sanXiao.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.pageSelector.PageSelector;
   import ddt.view.pageSelector.PageSelectorFactory;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import road7th.utils.DateUtils;
   import sanXiao.SanXiaoManager;
   
   public class SanXiaoViewStore extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _itemList:Vector.<SXStoreItem>;
      
      private var _pageSelecter:PageSelector;
      
      private var _timeRemainText:FilterFrameText;
      
      private var _crystalRemainText:FilterFrameText;
      
      private var _crystalIconBmp:Bitmap;
      
      public function SanXiaoViewStore(){super();}
      
      private function init() : void{}
      
      private function addEvents() : void{}
      
      private function removeEvents() : void{}
      
      public function update() : void{}
      
      public function dispose() : void{}
   }
}
