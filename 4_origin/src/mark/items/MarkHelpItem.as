package mark.items
{
   import mark.data.MarkSetTemplateData;
   import mark.mornUI.items.MarkHelpItemUI;
   
   public class MarkHelpItem extends MarkHelpItemUI
   {
       
      
      public function MarkHelpItem()
      {
         super();
      }
      
      public function set data(param1:MarkSetTemplateData) : void
      {
         lablName.text = param1.Name;
         lblDesc.htmlText = param1.HelpExplain;
         lblDesc.selectable = false;
         clipTypes.index = param1.SetId % 1000 - 1;
      }
   }
}
