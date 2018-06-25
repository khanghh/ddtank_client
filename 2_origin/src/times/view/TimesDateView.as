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
      
      public function TimesDateView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _controller = TimesController.Instance;
         _currentDate = new Date();
         if(_currentDate.getMonth() == 11)
         {
            _nextEditionDate = new Date(_currentDate.getFullYear() + 1,0,1);
         }
         else
         {
            _nextEditionDate = new Date(_currentDate.getFullYear(),_currentDate.getMonth() + 1,1);
         }
         _currentDateTxt = ComponentFactory.Instance.creatComponentByStylename("times.NormalText");
         _nextEditionDateTxt = ComponentFactory.Instance.creatComponentByStylename("times.NormalText");
         _currentEditionTxt = ComponentFactory.Instance.creatComponentByStylename("times.NormalText");
         _currentDateTxt.text = TimesUtils.getWords("times.CurrentDateText",_currentDate.getFullYear(),formatDate(_currentDate.getMonth() + 1),formatDate(_currentDate.getDate()));
         if(_controller.model.nextDate != "")
         {
            _nextDateText = String(_controller.model.nextDate);
            _nextEditionDateTxt.text = TimesUtils.getWords("times.NextEditionDateText",_nextDateText.substr(0,4),_nextDateText.substr(4,2),_nextDateText.substr(6,2));
         }
         else
         {
            _nextEditionDateTxt.text = TimesUtils.getWords("times.NextEditionDateText",_nextEditionDate.getFullYear(),formatDate(_nextEditionDate.getMonth() + 1),formatDate(_nextEditionDate.getDate()));
         }
         _currentEditionTxt.text = TimesUtils.getWords("times.CurrentEditionText",formatEdition(_controller.model.edition));
         TimesUtils.setPos(_currentDateTxt,"times.DateViewCurrentDateTextPos");
         TimesUtils.setPos(_nextEditionDateTxt,"times.DateViewNextEditionDateTextPos");
         TimesUtils.setPos(_currentEditionTxt,"times.DateViewCurrentEditionTextPos");
         var _loc1_:* = false;
         _currentEditionTxt.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _nextEditionDateTxt.mouseEnabled = _loc1_;
         _currentDateTxt.mouseEnabled = _loc1_;
         addChild(_currentDateTxt);
         addChild(_nextEditionDateTxt);
         addChild(_currentEditionTxt);
      }
      
      private function formatEdition(edition:int) : String
      {
         if(edition > 99)
         {
            return String(edition);
         }
         if(edition > 9)
         {
            return "0" + String(edition);
         }
         return "00" + String(edition);
      }
      
      private function formatDate(date:Number) : String
      {
         if(date > 9)
         {
            return String(date);
         }
         return "0" + String(date);
      }
      
      public function dispose() : void
      {
         _controller = null;
         ObjectUtils.disposeObject(_currentDateTxt);
         _currentDateTxt = null;
         ObjectUtils.disposeObject(_nextEditionDateTxt);
         _nextEditionDateTxt = null;
         ObjectUtils.disposeObject(_currentEditionTxt);
         _currentEditionTxt = null;
         _currentDate = null;
         _nextEditionDate = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
