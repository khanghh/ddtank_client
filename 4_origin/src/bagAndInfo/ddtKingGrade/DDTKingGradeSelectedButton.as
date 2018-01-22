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
      
      public function set actionStyle(param1:String) : void
      {
         _actionStyle = param1;
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
      
      override public function setFrame(param1:int) : void
      {
      }
      
      public function playAction() : void
      {
         var _loc2_:MovieClip = ClassUtils.CreatInstance(_actionStyle);
         addChild(_loc2_);
         PositionUtils.setPos(_loc2_,"ddtKingGrade.buttonActionPos");
         var _loc1_:MovieClipWrapper = new MovieClipWrapper(_loc2_,true,true);
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
         _text.text = param1.toString();
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set cost(param1:int) : void
      {
         if(_cost == param1)
         {
            return;
         }
         _cost = param1;
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
