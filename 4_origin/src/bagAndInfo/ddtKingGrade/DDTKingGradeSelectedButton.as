package bagAndInfo.ddtKingGrade
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import road7th.utils.MovieClipWrapper;
   
   public class DDTKingGradeSelectedButton extends SelectedButton
   {
       
      
      private var _text:FilterFrameText;
      
      private var _actionStyle:String;
      
      private var _level:int = 0;
      
      private var _cost:int = 0;
      
      public function DDTKingGradeSelectedButton()
      {
         super();
      }
      
      public function set actionStyle(value:String) : void
      {
         _actionStyle = value;
      }
      
      override protected function init() : void
      {
         _text = ComponentFactory.Instance.creat("ddtkinggrade.buttonLevelText");
         super.init();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_selectedButton)
         {
            addChild(_selectedButton);
         }
         if(_unSelectedButton)
         {
            addChild(_unSelectedButton);
         }
         if(_text)
         {
            addChild(_text);
         }
      }
      
      override public function setFrame(frameIndex:int) : void
      {
      }
      
      public function playAction() : void
      {
         var movie:MovieClip = ClassUtils.CreatInstance(_actionStyle);
         addChild(movie);
         PositionUtils.setPos(movie,"ddtKingGrade.buttonActionPos");
         var wrapper:MovieClipWrapper = new MovieClipWrapper(movie,true,true);
      }
      
      public function set level(value:int) : void
      {
         _level = value;
         _text.text = value.toString();
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set cost(value:int) : void
      {
         if(_cost == value)
         {
            return;
         }
         _cost = value;
         level = DDTKingGradeManager.Instance.getInfoByCost(_cost).Level;
      }
      
      public function get cost() : int
      {
         return _cost;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_text);
         _text = null;
         super.dispose();
      }
   }
}
