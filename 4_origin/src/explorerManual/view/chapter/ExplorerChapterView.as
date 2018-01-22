package explorerManual.view.chapter
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import explorerManual.ExplorerManualController;
   import explorerManual.data.ExplorerManualInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ExplorerChapterView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _leftView:ExplorerChapterLeftView;
      
      private var _rightView:ExplorerChapterRightView;
      
      private var _model:ExplorerManualInfo;
      
      private var _ctrl:ExplorerManualController;
      
      public function ExplorerChapterView(param1:ExplorerManualInfo, param2:ExplorerManualController)
      {
         super();
         _model = param1;
         _ctrl = param2;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.explorerManual.chapterBgAsset");
         _leftView = new ExplorerChapterLeftView(_model,_ctrl);
         _rightView = new ExplorerChapterRightView(_model,_ctrl);
         addChild(_bg);
         addChild(_leftView);
         addChild(_rightView);
      }
      
      public function dispose() : void
      {
         _model = null;
         _ctrl = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
