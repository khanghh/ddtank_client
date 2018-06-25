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
      
      public function set data(value:MarkSetTemplateData) : void
      {
         lablName.text = value.Name;
         lblDesc.htmlText = value.HelpExplain;
         lblDesc.selectable = false;
         clipTypes.index = value.SetId % 1000 - 1;
      }
   }
}
