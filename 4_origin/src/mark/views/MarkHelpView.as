package mark.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import ddt.manager.LanguageMgr;
   import mark.items.MarkHelpItem;
   import mark.mornUI.views.MarkHelpViewUI;
   import morn.core.handlers.Handler;
   
   public class MarkHelpView extends MarkHelpViewUI
   {
       
      
      public function MarkHelpView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc1_:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("mark.helpBg");
         bgCont.addChild(_loc1_);
         btnClose.clickHandler = new Handler(close);
         listHelp.renderHandler = new Handler(render);
         listHelp.selectHandler = new Handler(select);
         label4.text = LanguageMgr.GetTranslation("mark.mornUI.label4");
      }
      
      public function set data(param1:Array) : void
      {
         listHelp.array = param1;
      }
      
      private function select(param1:int) : void
      {
      }
      
      private function render(param1:MarkHelpItem, param2:int) : void
      {
         if(param2 < listHelp.array.length)
         {
            param1.data = listHelp.array[param2];
            param1.visible = true;
         }
         else
         {
            param1.visible = false;
         }
      }
      
      private function close() : void
      {
         dispose();
      }
   }
}
