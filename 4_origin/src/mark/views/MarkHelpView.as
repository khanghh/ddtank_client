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
         var bg:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("mark.helpBg");
         bgCont.addChild(bg);
         btnClose.clickHandler = new Handler(close);
         listHelp.renderHandler = new Handler(render);
         listHelp.selectHandler = new Handler(select);
         label4.text = LanguageMgr.GetTranslation("mark.mornUI.label4");
      }
      
      public function set data(arr:Array) : void
      {
         listHelp.array = arr;
      }
      
      private function select(index:int) : void
      {
      }
      
      private function render(item:MarkHelpItem, index:int) : void
      {
         if(index < listHelp.array.length)
         {
            item.data = listHelp.array[index];
            item.visible = true;
         }
         else
         {
            item.visible = false;
         }
      }
      
      private function close() : void
      {
         dispose();
      }
   }
}
