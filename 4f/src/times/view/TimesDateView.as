package times.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import times.TimesController;
   import times.utils.TimesUtils;
   
   public class TimesDateView extends Sprite implements Disposeable
   {
       
      
      private var _controller:TimesController;
      
      private var _currentDate:Date;
      
      private var _nextEditionDate:Date;
      
      private var _currentDateTxt:FilterFrameText;
      
      private var _nextEditionDateTxt:FilterFrameText;
      
      private var _currentEditionTxt:FilterFrameText;
      
      private var _nextDateText:String;
      
      public function TimesDateView(){super();}
      
      private function init() : void{}
      
      private function formatEdition(param1:int) : String{return null;}
      
      private function formatDate(param1:Number) : String{return null;}
      
      public function dispose() : void{}
   }
}
