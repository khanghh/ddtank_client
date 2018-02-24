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
      
      public function ExplorerChapterView(param1:ExplorerManualInfo, param2:ExplorerManualController){super();}
      
      private function initView() : void{}
      
      public function dispose() : void{}
   }
}
