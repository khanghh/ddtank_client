package chickActivation.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   
   public class LevelPacksComponent extends Component
   {
       
      
      public var levelIndex:int;
      
      public var isGray:Boolean;
      
      public function LevelPacksComponent()
      {
         super();
         this.tipStyle = "chickActivation.view.ChickActivationTip";
         this.tipDirctions = "0,1,2,7,3,6";
         this.mouseChildren = false;
      }
      
      public function buttonGrayFilters(isBool:Boolean) : void
      {
         if(isBool)
         {
            this.buttonMode = false;
            isGray = false;
            this.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            this.buttonMode = true;
            isGray = true;
            this.filters = null;
         }
      }
   }
}
