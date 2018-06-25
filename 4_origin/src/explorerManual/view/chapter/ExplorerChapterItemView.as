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
      
      public function ExplorerChapterItemView(type:int)
      {
         super();
         _chapterID = type;
         initView();
         buttonMode = true;
      }
      
      private function initView() : void
      {
         _titleIcon = ComponentFactory.Instance.creat("asset.explorerManual.chaptertxtAsset" + _chapterID);
         addChild(_titleIcon);
         _itemBtnIcon = ComponentFactory.Instance.creat("asset.explorerManual.chapterItembgAsset" + _chapterID);
         addChild(_itemBtnIcon);
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("explorerManual.chapterRight.itemProgressTxt");
         addChild(_progressTxt);
      }
      
      public function updateProgress(str:String) : void
      {
         _progressTxt.htmlText = str;
      }
      
      public function get chapterID() : int
      {
         return _chapterID;
      }
      
      public function dispose() : void
      {
         if(_titleIcon)
         {
            ObjectUtils.disposeObject(_titleIcon);
         }
         _titleIcon = null;
         if(_itemBtnIcon)
         {
            ObjectUtils.disposeObject(_itemBtnIcon);
         }
         _itemBtnIcon = null;
         if(_progressTxt)
         {
            ObjectUtils.disposeObject(_progressTxt);
         }
         _progressTxt = null;
      }
   }
}
