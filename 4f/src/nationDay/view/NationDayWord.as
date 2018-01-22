package nationDay.view
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class NationDayWord extends Sprite implements Disposeable
   {
       
      
      private var _word:Bitmap;
      
      private var _wordNum:FilterFrameText;
      
      private var _wordCount:int;
      
      private var _wordType:int;
      
      private var _resPath:String;
      
      public function NationDayWord(param1:String, param2:int, param3:int){super();}
      
      private function loadWord() : void{}
      
      protected function __onLoadComplete(param1:LoaderEvent) : void{}
      
      public function updateWordNum(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
