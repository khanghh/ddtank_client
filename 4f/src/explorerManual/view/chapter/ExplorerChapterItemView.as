package explorerManual.view.chapter
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ExplorerChapterItemView extends Sprite implements Disposeable
   {
       
      
      private var _titleIcon:Bitmap;
      
      private var _itemBtnIcon:Bitmap;
      
      private var _progressTxt:FilterFrameText;
      
      private var _chapterID:int;
      
      public function ExplorerChapterItemView(param1:int){super();}
      
      private function initView() : void{}
      
      public function updateProgress(param1:String) : void{}
      
      public function get chapterID() : int{return 0;}
      
      public function dispose() : void{}
   }
}
