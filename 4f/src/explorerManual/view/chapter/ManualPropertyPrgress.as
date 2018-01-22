package explorerManual.view.chapter
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import explorerManual.data.ExplorerManualInfo;
   import flash.display.Bitmap;
   
   public class ManualPropertyPrgress extends Component
   {
       
      
      protected var _progressLabel:FilterFrameText;
      
      protected var _proBitmap:Bitmap;
      
      protected var _proBitMask:Bitmap;
      
      protected var _value:Number = 0;
      
      protected var _max:Number = 100;
      
      private var _oldValue:Number = 0;
      
      private var _isInit:Boolean = false;
      
      private var _model:ExplorerManualInfo;
      
      public function ManualPropertyPrgress(param1:ExplorerManualInfo){super();}
      
      private function initView() : void{}
      
      public function setProgress(param1:Number, param2:Number) : void{}
      
      protected function drawProgress() : void{}
      
      private function updateLabel(param1:int) : void{}
      
      private function updateComplete() : void{}
      
      override public function dispose() : void{}
   }
}
