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
      
      public function NationDayWord(param1:String, param2:int, param3:int)
      {
         super();
         _resPath = param1;
         _wordType = param2;
         _wordCount = param3;
         loadWord();
      }
      
      private function loadWord() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.SITE_MAIN + "image\\writing\\" + _resPath + "\\icon.png?rnd=" + new Date().time.toString(),0);
         _loc1_.addEventListener("complete",__onLoadComplete);
         LoadResourceManager.Instance.startLoad(_loc1_,true);
      }
      
      protected function __onLoadComplete(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.loader;
         _loc2_.removeEventListener("complete",__onLoadComplete);
         _word = _loc2_.content as Bitmap;
         var _loc3_:* = 0.5;
         _word.scaleY = _loc3_;
         _word.scaleX = _loc3_;
         addChild(_word);
         _wordNum = ComponentFactory.Instance.creatComponentByStylename("nationDay.wordNum");
         addChild(_wordNum);
         updateWordNum(_wordCount);
      }
      
      public function updateWordNum(param1:int) : void
      {
         _wordCount = param1;
         if(_wordNum)
         {
            _wordNum.text = _wordCount.toString();
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_word);
         _word = null;
         ObjectUtils.disposeObject(_wordNum);
         _wordNum = null;
      }
   }
}
